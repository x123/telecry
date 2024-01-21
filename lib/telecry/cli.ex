defmodule Telecry.CLI do
  @secrets_path Path.expand("/run/secrets/tg/nixiumbot")

  def main(_opts \\ []) do
    {:ok, _started_apps} = init_or_die()

    vars = fetch_vars()
    tg_token = Keyword.get(vars, :tg_token)
    tg_target_id = Keyword.get(vars, :tg_target_id)

    if is_nil(tg_token) or is_nil(tg_target_id) do
      IO.puts("fatal error:need TG_TOKEN and TG_TARGET_ID defined in #{@secrets_path}")
      System.halt(1)
    end

    # this gets the full hostname, but it's not necessary
    # {:ok, fqdn} = :net_adm.dns_hostname(:net_adm.localhost)
    {:ok, hostname} = :inet.gethostname()
    {:ok, _message} = notify_target(tg_token, tg_target_id, hostname)
  end

  def init_or_die() do
    case Application.ensure_all_started(:telegram) do
      {:ok, started_apps} ->
        {:ok, started_apps}

      {:error, reason} ->
        IO.puts("error:#{inspect(reason)}")
        System.halt(1)
    end
  end

  def notify_target(tg_token, tg_target, hostname) do
    Telegram.Api.request(
      tg_token,
      "sendMessage",
      chat_id: tg_target,
      text: "#{hostname} is going down at #{DateTime.utc_now()}"
    )
  end

  # since we will be triggered as a google shutdown script we cannot rely on
  # env vars, so we parse them manually
  def fetch_vars() do
    File.read!(@secrets_path)
    |> String.split("\n", trim: true)
    |> Enum.map(fn item ->
      case String.split(item, "=", trim: true) do
        ["TG_TOKEN", tg_token] -> [tg_token: tg_token]
        ["TG_TARGET_ID", tg_target_id] -> [tg_target_id: tg_target_id]
      end
    end)
    |> List.flatten()
  end

  # unused, mainly to test that a token is working
  def get_updates(tg_token) do
    Telegram.Api.request(tg_token, "getUpdates")
  end
end
