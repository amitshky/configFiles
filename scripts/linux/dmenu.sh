#!/usr/bin/env bash

# List all executables in PATH
all_apps=$(dmenu_path)
# all_apps=$(compgen -c)

# List all Flatpak apps (only the app IDs, fast)
flatpak_apps=$(flatpak list --app --columns=application)
powermenu=$(printf "⏻  Shutdown\n⏾  Sleep\n  Restart\n󰍃  Logout")

# Combine, sort unique, feed to dmenu
selected=$(printf "%s\n%s\n%s\n" "$all_apps" "$flatpak_apps" "$powermenu" | dmenu -i -c -z 800 -l 8 -p "run:")

# Run the selected app
if [[ -n "$selected" ]]; then
    if flatpak info "$selected" &>/dev/null; then
        flatpak run "$selected" &
    else
        case "$selected" in
            *Shutdown)  systemctl poweroff -i ;;
            *Sleep)     slock systemctl suspend -i ;;
            *Restart)   systemctl reboot -i ;;
            *Logout)    pkill dwm ;;
            *)          $selected &>/dev/null & ;;
        esac
    fi
fi
