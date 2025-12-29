# Things to do after installing debian
NOTES: checkout `../linux_config/` for some config files that are general to linux.

```
apt update
apt upgrade
```

## install some essential packages
```
apt install xorg neovim vim git build-essential libx11-dev libxft-dev libxinerama-dev libxcb1-dev libxcb-res0-dev libx11-xcb-dev libxcb-util-dev networkmanager picom feh arandr pipewire pulseaudio unzip flatpak
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

## Download dwm, dwmblocks-async, st, and other suckless tools
- you want to build and install these 
    - run `make clean install` from the directories
```
mkdir ~/{dev,suckless}
git clone https://amitshky@github.com/amitshky/configFiles ~/dev/config
git clone https://amitshky@github.com/amitshky/st ~/suckless/st
git clone https://amitshky@github.com/amitshky/dwm ~/suckless/dwm
git clone https://amitshky@github.com/amitshky/dwmblocks-async ~/suckless/dwmblocks-async
git clone https://amitshky@github.com/amitshky/dmenu ~/suckless/dmenu
```
- compile all the suckless tools
```
// go to the directory (if you copy the bashrc file from ../bash/debian/, you can just use the aliases)
// see next step ## Copy configs
make clean install
```

## Copy configs
```
cp ~/dev/config/linux_config/.xinitrc ~/
cp ~/dev/config/linux_config/user-dirs.dirs ~/.config/
cp ~/dev/config/bash/debian/.bashrc ~/
cp ~/dev/config/bash/debian/.bash_profile ~/
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
apt install btop kitty dolphin firefox-esr keepassxc mpv qimgv lazygit gpick darktable copyq flameshot unclutter reptyr pulsemixer syncthing
```
- NOTE: if you want to change the default terminal dolphin opens, change `~/.config/kdeglobals`
```
[General]
TerminalApplication=st
```

## Install VSCode
- download the .deb package from [here](https://code.visualstudio.com/docs/setup/linux#_install-vs-code-on-linux)
```
apt install ./<file>.deb
```

## Install flatpak packages
```
flatpak install obsidian
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
apt install ./ueberzugpp_<version_latest>_amd64.deb
```

## Install lightdm
```
apt install lightdm
```
- make `~/.xinitrc` executable
- then copy `../linux_config/dwm.desktop` to `/usr/share/xsessions/`
- and don't forget to change which session lightdm loads when you login

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

### Set up pinentry for git-cm
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
systemctl disable NetworkManager-wait-online.service
```
