defmodule TelecryTest do
  use ExUnit.Case
  doctest Telecry.CLI

  test "should initialize the :telegram app" do
    assert {:ok, _} = Telecry.CLI.init_or_die()
  end
end
