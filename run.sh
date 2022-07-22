#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
APP_DIR="$DIR/"
PID_FILE="$APP_DIR/gr.pid"

echo $$ > "$PID_FILE"
lsof -i :8890 | grep 'ython' | awk '{print $2}' | xargs kill -9
sleep 3
nohup ./venv/bin/python -m apps.app >> "$APP_DIR/gr.log" &