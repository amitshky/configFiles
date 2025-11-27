feh --bg-scale ~/pictures/wallpaper.jpg
picom -b

# to help dolphin automatically detect drives
# /usr/lib/x86_64-linux-gnu/libexec/polkit-kde-authentication-agent-1 &
# udiskie -t &

flameshot &
copyq &
dwmblocks &

~/dev/config/scripts/linux/homeSecondMonitorSetupI3.sh &
~/dev/config/scripts/linux/volumeListener.sh &
~/dev/config/scripts/linux/hideCursor.sh &

pactl set-sink-volume @DEFAULT_SINK@ 25%

exec dwm
