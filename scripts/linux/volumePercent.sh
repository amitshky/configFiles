#!/usr/bin/env bash

SINK="@DEFAULT_SINK@"
VOL=$(pactl get-sink-volume "$SINK" | awk '{print $5}' | head -n1)
VOL_NUM=${VOL%\%} # remove %

case "$BLOCK_BUTTON" in
    1)  # left click  show volume
        notify-send -u low -h int:value:$VOL_NUM "  Volume" "$VOL" ;;
    2)  # middle click toggle mute
        pactl set-sink-mute "$SINK" toggle ;;
    3)  # right click  pulsemixer
        st -e pulsemixer & ;;
    4)  # scroll up volume up
        pactl set-sink-volume "$SINK" +5% ;;
    5)  # scroll down volume down
        pactl set-sink-volume "$SINK" -5% ;;
    *) ;;
esac

# Get mute state
MUTED=$(pactl get-sink-mute "$SINK" | awk '{print $2}')

if [[ "$MUTED" == "yes" ]]; then
    echo "MUTED"
else
    echo "$VOL"
fi
