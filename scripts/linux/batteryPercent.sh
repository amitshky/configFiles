#!/usr/bin/env bash

BAT="/org/freedesktop/UPower/devices/battery_BAT1"

INFO="$(upower -i "$BAT")"

PERCENTAGE=$(awk '/percentage/ {print $2}' <<< "$INFO")
PERC_NUM=${PERCENTAGE%\%} # remove %
STATE=$(awk '/state/ {print $2}' <<< "$INFO")

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
                TIME_TO_FULL=$(awk -F: '/time to full/ {gsub(/^ +| +$/,"",$2); print $2}' <<< "$INFO")
                notify-send " Battery Charging" "Time to charge: $TIME_TO_FULL\nBattery: $PERCENTAGE" -h int:value:$PERC_NUM -u normal
                ;;
            discharging)
                TIME_TO_EMPTY=$(awk -F: '/time to empty/ {gsub(/^ +| +$/,"",$2); print $2}' <<< "$INFO")
                if [[ $PERC_NUM -lt 20 ]]; then
                    notify-send "󱐋 Battery Discharging" "Time to empty: $TIME_TO_EMPTY\nBattery: $PERCENTAGE" -h int:value:$PERC_NUM -u critical
                else
                    notify-send "󱐋 Battery Discharging" "Time to empty: $TIME_TO_EMPTY\nBattery: $PERCENTAGE" -h int:value:$PERC_NUM -u normal
                fi
                ;;
            fully-charged)
                notify-send "✔ Battery Full" "Battery is fully charged!" ;;
        esac
        ;;
    # 2) notify-send "Battery" "Middle click detected" ;;  # middle click
    # 3) notify-send "Battery" "Right click detected" ;;   # right click
esac

# File to store the last notification timestamp
NOTIFY_TS_FILE="/tmp/battery_critical_ts"

# Current time in seconds
NOW=$(date +%s)

# Last notification time (default 0 if file doesn't exist)
LAST_NOTIFY=$(cat "$NOTIFY_TS_FILE" 2>/dev/null || echo 0)

# Interval (in seconds) to send the critical notification,
# but this won't send the notification in that exact interval
# because this script only gets called when dwmblocks sends a signal
INTERVAL=200

# Send critical notification if conditions met and interval passed
if [[ $PERC_NUM -lt 20 && $STATE == "discharging" && $((NOW - LAST_NOTIFY)) -ge INTERVAL ]]; then
    notify-send -u critical "󰀦 Battery critical ($PERCENTAGE)" "Plug-in the charger!!!"
    echo "$NOW" > "$NOTIFY_TS_FILE"
fi

echo "$ICON$PERCENTAGE"
