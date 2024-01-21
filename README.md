# Telecry

A simple Elixir script to notify of a GCE spot instance preemption event via
Telegram bot API token.

## Use

The `mix escript.build` output is used as a standalone shutdown script to be
applied to a Compute Engine instance's shutdown-script metadata. This is not
intended to be used as a normal Elixir package.

The script makes the following assumptions:

1. The secrets `TG_TOKEN` and `TG_TARGET_ID` exist in the file
   `/run/secrets/tg/nixiumbot`. You will very likely need to redefine
   `@secrets_path` in `lib/telecry/cli.ex`.

2. The format for the secrets file is:
```
TG_TOKEN=your-tg-token-here
TG_TARGET_ID=target-id-to-send-message-to
```
3. The resulting script output from `MIX_ENV=prod mix escript.build` is going
   to be larger than Google's allowed local limit of 256KB, so you will need to
   either copy the script to the server manually and target it's local path
   directly (e.g., `metadata.shutdown-script = #! /path/to/escript
   /path/to/telecry`)

Alternatively, you should be able to copy it to a bucket and use
`metadata.shutdown-script-url`.
