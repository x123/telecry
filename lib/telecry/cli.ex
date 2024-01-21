defmodule Telecry.CLI do
  def init_or_die() do
    case Application.ensure_all_started(:telegram) do
      {:ok, started_apps} ->
        {:ok, started_apps}

      {:error, reason} ->
        IO.puts("error:#{inspect(reason)}")
        System.halt(1)
    end
  end

  def main(_opts \\ []) do
    {:ok, _started_apps} = init_or_die()
    tg_token = System.fetch_env!("TG_TOKEN")

    status = Telegram.Api.request(tg_token, "getMe")
    IO.inspect(status)
  end
end
