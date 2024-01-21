# Telecry

A simple Elixir script to notify of a GCE spot instance preemption event via
Telegram bot API token.

## Use

The `mix escript.build` output is used as a standalone shutdown script to be
applied to a Compute Engine instance's shutdown-script metadata. This is not
intended to be used as a normal Elixir package.
