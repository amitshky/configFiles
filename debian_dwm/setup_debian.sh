#! /usr/bin/env bash

sudo apt update
sudo apt upgrade

# install packages
sudo apt install xorg neovim vim git build-essential libx11-dev libxft-dev libxinerama-dev libxcb1-dev libxcb-res0-dev libx11-xcb-dev libxcb-util-dev libxrandr-dev network-manager picom feh arandr pipewire pulseaudio unzip flatpak ntfs-3g pipewire-audio-client-libraries wireplumber bluez playerctl brightnessctl tmux pass gnupg2 clang clang-tools nodejs npm python3-venv python3-pip python-is-python3 ffmpeg 7zip jq poppler-utils fd-find ripgrep fzf zoxide imagemagick pinentry-gtk2 pinentry-tty lua5.1 luarocks adwaita-icon-theme adwaita-icon-theme-legacy breeze-icon-theme lxappearance qt5ct qalc xclip libavcodec-extra breeze gnome-themes-extra btop firefox-esr pcmanfm keepassxc mpv qimgv lazygit gpick darktable copyq flameshot unclutter-xfixes pulsemixer syncthing dunst yt-dlp gallery-dl qbittorrent qalculate-qt okular calcurse libreoffice libreoffice-gtk3 ark krename valgrind mkvtoolnix mkvtoolnix-gui bear dolphin udisks2 kde-cli-tools polkit-kde-agent-1

# install ueberzugpp (debian 13)
echo 'deb http://download.opensuse.org/repositories/home:/justkidding/Debian_13/ /' | sudo tee /etc/apt/sources.list.d/home:justkidding.list
curl -fsSL https://download.opensuse.org/repositories/home:justkidding/Debian_13/Release.key | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/home_justkidding.gpg > /dev/null
sudo apt update
sudo apt install ueberzugpp

# clone a few repos
mkdir -p ~/{dev,suckless,.fonts,.config,downloads,documents,pictures,videos} /mnt/{hdd,ssd,windows,camera}
git clone https://amitshky@github.com/amitshky/configFiles ~/dev/config
git clone https://amitshky@github.com/amitshky/st ~/suckless/st
git clone https://amitshky@github.com/amitshky/dwm ~/suckless/dwm
git clone https://amitshky@github.com/amitshky/dmenu ~/suckless/dmenu
git clone https://amitshky@github.com/amitshky/dwmblocks-async ~/suckless/dwmblocks-async
git clone https://amitshky@github.com/amitshky/slock ~/suckless/slock

# copy configs
# TODO: this should be replaced with stow
cp ~/dev/config/linux_config/.xinitrc ~/
cp ~/dev/config/linux_config/.Xresources ~/
cp ~/dev/config/linux_config/.profile ~/
cp ~/dev/config/linux_config/user-dirs.dirs ~/.config/
cp ~/dev/config/linux_config/mimeapps.list ~/.config/
cp ~/dev/config/bash/debian/.bashrc ~/
cp ~/dev/config/bash/debian/.bash_profile ~/
mkdir -p ~/.config/menus
cp ~/dev/config/linux_config/applications.menu ~/.config/menus/
cp ~/dev/config/linux_config/gpg-agent.conf ~/.gnupg/gpg-agent.conf

# install jetbrains mono and gcm
cd ~/downloads
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/JetBrainsMono.zip
mkdir -p ~/.fonts/JetBrainsMono/
unzip JetBrainsMono.zip -d ~/.fonts/JetBrainsMono/ 
fc-cache
wget https://github.com/git-ecosystem/git-credential-manager/releases/download/v2.6.1/gcm-linux_amd64.2.6.1.deb
dpkg -i gcm-linux_amd64.2.6.1.deb 
cd ~

# gtk theming
cp ~/dev/config/linux_config/gtk-3.0/ ~/.config -r
cp ~/dev/config/linux_config/gtk-4.0/ ~/.config -r
cp ~/dev/config/linux_config/.gtkrc-2.0 ~/

# install rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
rustup update
# install yazi
cargo install --force yazi-build

# this just freezes dolphin and other apps when they start so remove them
sudo apt purge xdg-desktop-portal*
sudo apt autoremove
