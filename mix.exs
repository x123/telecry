defmodule Telecry.MixProject do
  use Mix.Project

  def project do
    [
      app: :telecry,
      version: "0.1.0",
      elixir: "~> 1.16",
      escript: escript(),
      dialyzer: [flags: ["-Wunmatched_returns", :error_handling, :underspecs]],
      # start_permanent: Mix.env() == :prod,
      deps: deps(),
      compilers: [:leex] ++ Mix.compilers()
    ]
  end

  def escript do
    [
      main_module: Telecry.CLI,
      app: nil,
      shebang: "#! /usr/bin/env escript\n"
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:telegram, github: "visciang/telegram", tag: "1.2.1"},
      {:dialyxir, "~> 1.4", only: [:dev, :test], runtime: false}
    ]
  end
end
