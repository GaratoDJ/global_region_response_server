#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
APP_DIR="$DIR/"
PID_FILE="$APP_DIR/gr.pid"

pushd "$APP_DIR"
if [ ! -s "$PID_FILE" ] || ! kill -0 $(cat $PID_FILE) > /dev/null 2>&1; then
  echo $$ > "$PID_FILE"
  ./venv/bin/python -m apps.app >> "$APP_DIR/gr.log"
fi
popd
