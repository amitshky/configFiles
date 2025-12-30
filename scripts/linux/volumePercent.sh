#!/usr/bin/env bash

SINK="@DEFAULT_SINK@"

OUT_STR=""
VOL_NUM=0

# get mute state
MUTED=$(pactl get-sink-mute "$SINK" | awk '{print $2}')

if [[ "$MUTED" == "yes" ]]; then
    OUT_STR="MUTED"
else
    VOL=$(pactl get-sink-volume "$SINK" | awk '{print $5}' | head -n1)
    VOL_NUM=${VOL%\%}   # remove percent sign
    OUT_STR="$VOL"
fi

# handle mouse clicks
case "$BLOCK_BUTTON" in
    1)  # left click, show notification
        if [[ "$OUT_STR" == "MUTED" ]]; then
            notify-send -u critical "  Volume" "MUTED"
        else
            notify-send -u low -h int:value:"$VOL_NUM" "  Volume" "$OUT_STR"
        fi
        ;;
    2)  # middle click, toggle mute
        pactl set-sink-mute "$SINK" toggle ;;
    3)  # right click, open pulsemixer
        st -e pulsemixer & ;;
    4)  # scroll up, increase volume
        pactl set-sink-volume "$SINK" +5% ;;
    5)  # scroll down, decrease volume
        pactl set-sink-volume "$SINK" -5% ;;
    *) ;;  # ignore other buttons
esac

# output volume or MUTE for status bar
echo "$OUT_STR"
