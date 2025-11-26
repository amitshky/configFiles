# Things to do after installing debian

```
apt update
apt upgrade
```

## install some essential packages
- check if build-essential is installed, if not also include "build-essential" below
```
apt install xorg stterm neovim vim git libx11-dev libxft-dev libxinerama-dev
```

## Install nvidia drivers
```
apt install linux-headers-amd64
nvim /etc/apt/sources.list
```
-  add following deb sources
```
# Debian Sid
deb http://deb.debian.org/debian/ sid main contrib non-free non-free-firmware
```
- then update and install drivers
```
apt update
apt upgrade
apt install nvidia-driver firmware-misc-nonfree
```

## Download dwm, dwmblocks-async, and st
- you want to build and install these 
    - run `make clean install` from the directories
```
git clone https://github.com/amitshky/st ~/st
git clone https://github.com/amitshky/dwm ~/dwm
git clone https://github.com/amitshky/dwmblocks-async ~/dwmblocks-async
```

## Configure dwm
```
cd ~/dwm
cp config.def.h config.h
sudo chown -R almostblue@deiban .
sudo make clean install
echo "exec dwm" >> ../.xinitrc
cd ~
```

## Configure git credential manager
- download gcm first then run the following
```
dpkg -i gcm-linux_amd64.2.6.1.deb 
```

## Set up git-cm
```
gpg --full-generate-key 
git config --global credential.credentialStore gpg
pass init "<type ur id here>"
```

## Set up tui pinentry for git-cm
- include `export GPG_TTY=$(tty)` in `.bashrc`
- install `pinentry-qt` (or install gtk or cli(curses) version of pinentry)
```
sudo apt install pinentry-qt
```
- instead of doing this you can also copy the `gpg-agent.conf` file included in this directory
```
echo "pinentry-program /usr/bin/pinentry-qt" >> ~/.gnupg/gpg-agent.conf
```
- restart the agent
```
gpgconf --kill gpg-agent
gpgconf --launch gpg-agent
```

## Install jetbrains mono nerd font
- download jebrains mono nerd font then,
```
unzip JetBrainsMono-2.304.zip 
mkdir ~/.fonts
mkdir ~/.fonts/JetBrainsMono/
```
- then move all ttf to .fonts
```
fc-cache
```

## Install rust if you want to
```
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
rustup update
```

## Install rest of the packages
```
apt install kitty firefox-esr dmenu networkmanager picom pipewire pulseaudio btop keepassxc fdisk feh arandr pass gnupg2 clang mpv qimgv ffmpeg 7zip jq poppler-utils fd-find ripgrep fzf zoxide imagemagick
```

## Install packages from cargo
- yazi (you have to build it)
    - dependencies `apt install ffmpeg 7zip jq poppler-utils fd-find ripgrep fzf zoxide imagemagick`
```
cargo install --force yazi-build
```

## If you want dolphin to detect drives
```
apt install dolpin
apt install udisks2 udiskie gvfs gvfs-backends polkit-kde-agent-1
```

## Speeding-up boot-time
```
sudo systemctl disable NetworkManager-wait-online.service
```
