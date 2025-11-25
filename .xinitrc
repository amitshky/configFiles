feh --bg-scale ~/pictures/wallpaper.jpg
picom -b

# to help dolphin automatically detect drives
# /usr/lib/x86_64-linux-gnu/libexec/polkit-kde-authentication-agent-1 &
# udiskie -t &

dwmblocks &
~/dev/config/scripts/linux/homeSecondMonitorSetupI3.sh &

exec dwm
