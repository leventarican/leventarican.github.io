#!/bin/sh
# stoppt den mit start.sh gestarteten Zola-Dev-Server
cd "$(dirname "$0")" || exit 1

PIDFILE=.zola.pid

if [ -f "$PIDFILE" ] && kill -0 "$(cat "$PIDFILE")" 2>/dev/null; then
    kill "$(cat "$PIDFILE")"
    echo "zola gestoppt (PID $(cat "$PIDFILE"))"
else
    echo "zola läuft nicht"
fi
rm -f "$PIDFILE"
