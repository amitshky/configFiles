#!/usr/bin/env bash

STATE_FILE="/tmp/dwmblocks_clock_seconds"

if [ "$BLOCK_BUTTON" = "1" ]; then
    if [ -f "$STATE_FILE" ]; then
        rm "$STATE_FILE"
    else
        touch "$STATE_FILE"
    fi
fi

if [ -f "$STATE_FILE" ]; then
    date '+%b %d, %Y  %a %H:%M:%S'
else
    date '+%F %a %H:%M'
fi
