#!/usr/bin/env bash

# List all executables in PATH
all_apps=$(compgen -c)

# List all Flatpak apps (only the app IDs, fast)
flatpak_apps=$(flatpak list --app --columns=application)

# Combine, sort unique, feed to dmenu
selected=$(printf "%s\n%s\n" "$all_apps" "$flatpak_apps" | sort -u | dmenu -i -c -z 800 -l 8 -p "run:")

# Run the selected app
if [[ -n "$selected" ]]; then
    if flatpak info "$selected" &>/dev/null; then
        flatpak run "$selected" &
    else
        nohup "$selected" &>/dev/null &
    fi
fi
