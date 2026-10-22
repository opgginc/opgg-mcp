#!/usr/bin/env bash
# Send one MCP initialize on stdio and require protocolVersion in the result.
set -eu

seconds=25
log=boot.log

if [[ $# -lt 1 ]]; then
  echo "usage: boot-proxy.sh <command> [args...]" >&2
  exit 1
fi

init='{"jsonrpc":"2.0","id":1,"method":"initialize","params":{"protocolVersion":"2025-06-18","capabilities":{},"clientInfo":{"name":"ci","version":"0"}}}'

# grep closes the pipe on the first match. Without pipefail, that SIGPIPE is not a failure.
set +o pipefail
if ! { echo "$init"; sleep $((seconds + 5)); } | timeout "$seconds" "$@" 2>"$log" | grep -m1 -q '"protocolVersion"'; then
  cat "$log" >&2 || true
  exit 1
fi
