#!/usr/bin/env bash
# Preview with SCSS hot-reload.
#
# Quarto's file watcher doesn't track theme SCSS files.
# This polls custom.scss and touches talk.qmd on change,
# triggering Quarto's normal rebuild pipeline.
#
# Usage:  ./dev.sh [extra quarto preview flags...]

set -eu
cd "$(dirname "$0")"

SCSS="custom.scss"
QMD="talk.qmd"

scss_watch() {
  local last
  last=$(stat -c %Y "$SCSS" 2>/dev/null || echo 0)
  while true; do
    sleep 0.5
    local now
    now=$(stat -c %Y "$SCSS" 2>/dev/null || echo 0)
    if [ "$now" != "$last" ]; then
      last=$now
      touch -c "$QMD"            # -c: don't create if missing
      echo "[scss] change detected → rebuild ($(date +%H:%M:%S))"
    fi
  done
}

scss_watch &
WATCH_PID=$!
trap 'kill $WATCH_PID 2>/dev/null; wait $WATCH_PID 2>/dev/null' EXIT

# Default host/port; user args override
ARGS=()
case "$*" in *--host*) ;; *) ARGS+=(--host 0.0.0.0) ;; esac
case "$*" in *--port*) ;; *) ARGS+=(--port 8889)     ;; esac

exec quarto preview "$QMD" "${ARGS[@]}" "$@"
