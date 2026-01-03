# Things to do after installing debian
NOTES: checkout `../linux_config/` for some config files that are general to linux.

```
apt update
apt upgrade
```

## install some essential packages
```
apt install xorg neovim vim git build-essential libx11-dev libxft-dev libxinerama-dev libxcb1-dev libxcb-res0-dev libx11-xcb-dev libxcb-util-dev libxrandr-dev networkmanager picom feh arandr pipewire pulseaudio unzip flatpak ntfs-3g
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
git clone https://amitshky@github.com/amitshky/slock ~/suckless/slock
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

## Install rust
```
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
rustup update
```

## Install some common dependencies
```
apt install pass gnupg2 clang nodejs npm python3 python3-venv python3-pip ffmpeg 7zip jq poppler-utils fd-find ripgrep fzf zoxide imagemagick pinentry-curses lua5.1 luarocks adwaita-icon-theme adwaita-icon-theme-legacy breeze lxappearance qt6ct qalc xclip
```

## Install rest of the packages
```
apt install btop firefox-esr pcmanfm keepassxc mpv qimgv lazygit gpick darktable copyq flameshot unclutter-xfixes pulsemixer syncthing dunst yt-dlp gallery-dl qbittorrent qalculate-qt
```
- NOTE: after installing pcmanfm, also move gtk-3.0 and gtk-4.0 folders to config
```
cp ~/dev/config/gtk-3.0/ ~/.config
cp ~/dev/config/gtk-4.0/ ~/.config
```
- NOTE: the file manager that I have here is pcmanfm and you can use lxapperane to change the theme of the file manager
- NOTE: dolphin is not installed
    - if you want to change the default terminal dolphin opens, change `~/.config/kdeglobals`
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
- impala (wifi manager tui)
    - dependency `iwd` (there could be more)
```
cargo install impala
// then
nvim /usr/share/dbus-1/services/org.freedesktop.Notifications.service
// add these
[D-BUS Service]
Name=org.freedesktop.Notifications
Exec=/usr/lib/notification-daemon/notification-daemon
```

## Install packages from pipx
- calcure is a tui calendar
```
apt install pipx
pipx install calcure
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
- add this to `~/.xinitrc`
```
/usr/lib/x86_64-linux-gnu/libexec/polkit-kde-authentication-agent-1 &
udiskie -t &
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

## Color schemes and theme customization
These might be useful
- [kde theming](https://www.lorenzobettini.it/2024/08/better-kde-theming-and-styling-in-hyprland/)
- [qt theming](https://www.hyprflux.dev/features/qt-theming.html#color-schemes)

## To disable Display power management signal
```
xset -dpms
```
