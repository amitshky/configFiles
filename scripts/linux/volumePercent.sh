#!/usr/bin/env bash

pactl get-sink-volume @DEFAULT_SINK@ | awk '{print $5}'

case "$BLOCK_BUTTON" in
    1)  # left click open pulsemixer in st
        st -e pulsemixer & ;;
    4)  # scroll up increase volume
        pactl set-sink-volume @DEFAULT_SINK@ +5% ;;
    5)  # scroll down decrease volume
        pactl set-sink-volume @DEFAULT_SINK@ -5% ;;
esac
