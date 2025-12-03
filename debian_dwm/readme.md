# Things to do after installing debian
NOTES: checkout `../linux_config/` for some config files that are general to linux.

```
apt update
apt upgrade
```

## install some essential packages
```
apt install xorg stterm neovim vim git build-essential libx11-dev libxft-dev libxinerama-dev libxcb1-dev libxcb-util-dev networkmanager picom dmenu feh arandr pipewire pulseaudio unzip
```

## Install nvidia drivers
- [Reference](https://wiki.debian.org/NvidiaGraphicsDrivers)
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
mkdir ~/dev/
git clone https://github.com/amitshky/configFiles ~/dev/config
git clone https://github.com/amitshky/st ~/st
git clone https://github.com/amitshky/dwm ~/dwm
git clone https://github.com/amitshky/dwmblocks-async ~/dwmblocks-async
cp ~/dev/config/linux_config/.xinitrc ~/
cp ~/dev/config/linux_config/user-dirs.dirs ~/.config/
```

## Configure dwm
- NOTE: this is only to show how you should configure dwm
```
cd ~/dwm
cp config.def.h config.h
sudo chown -R almostblue@deiban .
sudo make clean install
echo "exec dwm" >> ../.xinitrc
cd ~
```

## Start dwm
```
startx
```

## Install jetbrains mono nerd font
- download jebrains mono nerd font then,
    - [download link](https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/JetBrainsMono.zip)
```
mkdir -p ~/.fonts/JetBrainsMono/
unzip JetBrainsMono.zip -d ~/.fonts/JetBrainsMono/ 
fc-cache
```

## Install rust if you want to
```
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
rustup update
```

## Install some common dependencies
```
apt install pass gnupg2 clang nodejs npm python3 python3-venv ffmpeg 7zip jq poppler-utils fd-find ripgrep fzf zoxide imagemagick pinentry-qt
```

## Install rest of the packages
- NOTE: `reptyr` - Utility for taking an existing running program and attaching it to a new terminal.
```
apt install btop kitty dolphin firefox-esr keepassxc mpv qimgv lazygit gpick darktable copyq flameshot unclutter reptyr
```

## Install packages from cargo
- yazi (you have to build it)
    - dependencies `ffmpeg 7zip jq poppler-utils fd-find ripgrep fzf zoxide imagemagick`
```
cargo install --force yazi-build
```

## Install Ueberzugpp to render images in st
- download from [here](https://software.opensuse.org/download.html?project=home%3Ajustkidding&package=ueberzugpp)
```
sudo apt install ./ueberzugpp_<version_latest>_amd64.deb
```


## If you want dolphin to detect drives
```
apt install udisks2 udiskie gvfs gvfs-backends polkit-kde-agent-1
```

## Configure git credential manager
- download gcm first then run the following
```
dpkg -i gcm-linux_amd64.2.6.1.deb 
```

### Set up git-cm
```
gpg --full-generate-key 
git config --global credential.credentialStore gpg
pass init "<type ur id here>"
```

### Set up tui pinentry for git-cm
- include `export GPG_TTY=$(tty)` in `.bashrc`
- instead of doing this you can also copy the `gpg-agent.conf` file included in this directory
```
echo "pinentry-program /usr/bin/pinentry-qt" >> ~/.gnupg/gpg-agent.conf
```
- restart the agent
```
gpgconf --kill gpg-agent
gpgconf --launch gpg-agent
```

## Speeding-up boot-time
```
sudo systemctl disable NetworkManager-wait-online.service
```
