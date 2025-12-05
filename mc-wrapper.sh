#!/bin/bash

INSTANCE=$1
SOCKET="minecraft"
PIPE="/tmp/mc-log-$INSTANCE"

rm -f "$PIPE"
mkfifo "$PIPE"

tmux -L "$SOCKET" new-session -s "$INSTANCE" -d './start.sh'
tmux -L "$SOCKET" pipe-pane -t "$INSTANCE" "cat > $PIPE"
cat "$PIPE"

rm -f "$PIPE"

