#!/usr/bin/env bash
# Confirm the stdio proxy stays up after connecting to the remote MCP endpoint.
# A failed connect logs "could not start the proxy" and exits within about a second.
set -euo pipefail

seconds="${BOOT_WAIT_SECONDS:-25}"
log="${BOOT_LOG:-boot.log}"

fail() {
  echo "$1" >&2
  if [[ -f "$log" ]]; then
    cat "$log" >&2 || true
  fi
  exit 1
}

if [[ "${1:-}" == "docker" && "${2:-}" == "inspect-wait" ]]; then
  name="${3:?container name required}"
  : >"$log"
  for _ in $(seq 1 "$seconds"); do
    running="$(docker inspect -f '{{.State.Running}}' "$name")"
    if [[ "$running" != "true" ]]; then
      docker logs "$name" >"$log" 2>&1 || true
      fail "container exited before the remote connection stayed up"
    fi
    sleep 1
  done
  docker logs "$name" >"$log" 2>&1 || true
  if grep -q "could not start the proxy" "$log"; then
    fail "container reported a startup failure"
  fi
  echo "container still running after ${seconds}s"
  docker stop -t 2 "$name" >/dev/null
  exit 0
fi

if [[ "$#" -lt 1 ]]; then
  echo "usage: boot-proxy.sh <command> [args...]" >&2
  exit 1
fi

"$@" >"$log" 2>&1 < <(sleep $((seconds + 15))) &
pid=$!

for _ in $(seq 1 "$seconds"); do
  if ! kill -0 "$pid" 2>/dev/null; then
    wait "$pid" || true
    fail "proxy exited before the remote connection stayed up"
  fi
  sleep 1
done

if grep -q "could not start the proxy" "$log"; then
  kill -INT "$pid" 2>/dev/null || true
  wait "$pid" || true
  fail "proxy reported a startup failure"
fi

echo "proxy still running after ${seconds}s"
kill -INT "$pid" 2>/dev/null || true
wait "$pid" || true
cat "$log" || true
