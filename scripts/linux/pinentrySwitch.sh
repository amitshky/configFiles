#!/usr/bin/env bash
set -e

GPG_DIR="$HOME/.gnupg"
CONF="$GPG_DIR/gpg-agent.conf"

restart_gpgagent() {
    gpgconf --kill gpg-agent
    gpgconf --launch gpg-agent
}

set_pinentry() {
    local pinentry="$1"

    mkdir -p "$GPG_DIR"
    touch "$CONF"

    # remove existing pinentry-program line
    sed -i '/^pinentry-program/d' "$CONF"
    echo "pinentry-program $pinentry" >> "$CONF"
}

case "$1" in
    tty)
        set_pinentry /usr/bin/pinentry-tty
        restart_gpgagent
        ;;
    gui)
        set_pinentry /usr/bin/pinentry-gtk-2
        restart_gpgagent
        ;;
    *)
        echo "Usage: $0 {tty|gui}"
        exit 1
        ;;
esac
