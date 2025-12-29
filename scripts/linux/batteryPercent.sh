#!/usr/bin/env bash

BAT="/org/freedesktop/UPower/devices/battery_BAT1"

INFO="$(upower -i "$BAT")"

PERCENTAGE=$(awk '/percentage/ {print $2}' <<< "$INFO")
PERC_NUM=${PERCENTAGE%\%} # remove %
STATE=$(awk '/state/ {print $2}' <<< "$INFO")
TIME_TO_FULL=$(awk -F: '/time to full/ {gsub(/^ +| +$/,"",$2); print $2}' <<< "$INFO")
TIME_TO_EMPTY=$(awk -F: '/time to empty/ {gsub(/^ +| +$/,"",$2); print $2}' <<< "$INFO")

case "$STATE" in
    charging)      ICON=" ";;
    discharging)   ICON="󱐋 ";;
    fully-charged) ICON="✔ ";;
    *)             ICON="";;
esac

# BLOCK_BUTTON is set by dwmblocks
case "$BLOCK_BUTTON" in
    1) # left click
        case "$STATE" in
            charging)
                notify-send " Battery Charging" "Time to charge: $TIME_TO_FULL" ;;
            discharging)
                if [[ $PERC_NUM -lt 20 ]]; then
                    notify-send " Battery Discharging" "Time to empty: $TIME_TO_EMPTY\nBattery: $PERCENTAGE" -h int:value:$PERC_NUM -u critical
                else
                    notify-send " Battery Discharging" "Time to empty: $TIME_TO_EMPTY\nBattery: $PERCENTAGE" -h int:value:$PERC_NUM -u normal
                fi
                ;;
            fully-charged)
                notify-send "✔ Battery Full" "Battery is fully charged!" ;;
        esac
        ;;
    # 2) notify-send "Battery" "Middle click detected" ;;  # middle click
    # 3) notify-send "Battery" "Right click detected" ;;   # right click
    *) ;; # ignore others
esac

# Compare numerically
if [[ $PERC_NUM -lt 20 ]]; then
    notify-send -u critical "Battery critical" "Plug-in the charger!!!"
fi

echo "$ICON$PERCENTAGE"
