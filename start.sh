#!/bin/sh
# startet den Zola-Dev-Server im Hintergrund (http://127.0.0.1:1111)
cd "$(dirname "$0")" || exit 1

PIDFILE=.zola.pid
LOGFILE=.zola.log

if [ -f "$PIDFILE" ] && kill -0 "$(cat "$PIDFILE")" 2>/dev/null; then
    echo "zola läuft bereits (PID $(cat "$PIDFILE"))"
    exit 0
fi

nohup zola serve > "$LOGFILE" 2>&1 &
echo $! > "$PIDFILE"
echo "zola gestartet (PID $!) -> http://127.0.0.1:1111, Log: $LOGFILE"
