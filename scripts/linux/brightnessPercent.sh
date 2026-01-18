#!/usr/bin/env bash

# brightnessctl device (usually works without specifying, but kept explicit)
DEVICE=""
# DEVICE="-d intel_backlight"

OUT_STR=""
BRIGHT_NUM=0

# get current brightness percentage (integer)
BRIGHT_NUM=$(brightnessctl $DEVICE -m | cut -d',' -f4 | tr -d '%')
OUT_STR="${BRIGHT_NUM}%"

# handle mouse clicks
case "$BLOCK_BUTTON" in
    1)  # left click: show notification
        notify-send -u low -h int:value:"$BRIGHT_NUM" "󰃝  Brightness" "$OUT_STR"
        ;;
    2)  # middle click: toggle low/high (example: 10% <-> 100%)
        if [ "$BRIGHT_NUM" -le 15 ]; then
            brightnessctl set 100% >/dev/null 2>&1 || true
        else
            brightnessctl set 10% >/dev/null 2>&1 || true
        fi
        ;;
    # 3)  # right click
    #     ;;
    4)  # scroll up: increase brightness
        brightnessctl set +10% >/dev/null 2>&1 || true ;;
    5)  # scroll down: decrease brightness
        brightnessctl set 10%- >/dev/null 2>&1 || true ;;
    *) ;;
esac

# output brightness for status bar
echo "$OUT_STR"
exit 0
