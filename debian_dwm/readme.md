# Things to do after installing debian
NOTES: checkout `../linux_config/` for some config files that are general to linux.

```
apt update
apt full-upgrade
```

## install some essential packages
```
apt install xorg neovim vim git build-essential libx11-dev libxft-dev libxinerama-dev libxcb1-dev libxcb-res0-dev libx11-xcb-dev libxcb-util-dev libxrandr-dev network-manager picom feh arandr pipewire pulseaudio unzip flatpak ntfs-3g pipewire-audio-client-libraries wireplumber bluez playerctl brightnessctl tmux rfkill
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
mkdir ~/{dev,suckless,.config}
mkdir /mnt/{hdd,ssd,windows,camera}
git clone https://amitshky@github.com/amitshky/configFiles ~/dev/config
git clone https://amitshky@github.com/amitshky/st ~/suckless/st
git clone https://amitshky@github.com/amitshky/dwm ~/suckless/dwm
git clone https://amitshky@github.com/amitshky/dmenu ~/suckless/dmenu
git clone https://amitshky@github.com/amitshky/dwmblocks-async ~/suckless/dwmblocks-async
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
cp ~/dev/config/linux_config/.Xresources ~/
cp ~/dev/config/linux_config/.profile ~/
cp ~/dev/config/linux_config/user-dirs.dirs ~/.config/
cp ~/dev/config/linux_config/mimeapps.list ~/.config/
cp ~/dev/config/bash/debian/.bashrc ~/
cp ~/dev/config/bash/debian/.bash_profile ~/
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
apt install pass gnupg2 clang clang-tools nodejs npm python3-venv python3-pip python-is-python3 ffmpeg 7zip jq poppler-utils fd-find ripgrep fzf zoxide imagemagick pinentry-gtk2 pinentry-tty lua5.1 luarocks adwaita-icon-theme adwaita-icon-theme-legacy breeze-icon-theme lxappearance qt5ct qalc xclip libavcodec-extra breeze gnome-themes-extra
```
- NOTE: there is both pinentry-gtk2 and pinentry-tty, you can switch using the script `$HOME/dev/config/scripts/linux/pinetrySwitch.sh`

## Install rest of the packages
```
apt install btop firefox-esr pcmanfm keepassxc mpv qimgv lazygit gpick darktable copyq flameshot unclutter-xfixes pulsemixer syncthing dunst yt-dlp gallery-dl qbittorrent qalculate-qt okular calcurse libreoffice libreoffice-gtk3 ark krename valgrind mkvtoolnix mkvtoolnix-gui bear
```
- NOTE: after installing pcmanfm, also move gtk-3.0 and gtk-4.0 folders to config
```
cp ~/dev/config/linux_config/gtk-3.0/ ~/.config -r
cp ~/dev/config/linux_config/gtk-4.0/ ~/.config -r

# also do this for pinentry-gtk-2
cp ~/dev/config/linux_config/.gtkrc-2.0 ~/
```
- NOTE: the file manager that I have here is pcmanfm and you can use lxapperance to change the theme of the file manager

### If you want to install dolphin using apt
- if you want to install dolphin, also install udisks2
    - you can query other devices (drives)
```
apt install dolphin udisks2 kde-cli-tools polkit-kde-agent-1
```
- add this to `~/.xinitrc`
```
/usr/lib/x86_64-linux-gnu/libexec/polkit-kde-authentication-agent-1 &
```
- if you want to change the default terminal dolphin opens, change `~/.config/kdeglobals`
```
[General]
TerminalApplication=st
```
- for application menu
```
mkdir -p ~/.config/menus
cp ~/dev/config/linux_config/applications.menu ~/.config/menus/
```

## Setup Network Manager
```
nvim /etc/network/interfaces

# then remove/comment the line
# The primary network interface
allow-hotplug wlp0s20f3
iface wlp0s20f3 inet dhcp
	wpa-ssid <wifi_name>
 	wpa-psk  <wifi_password>

# then
sudo nvim /etc/NetworkManager/NetworkManager.conf

# change managed to true
[main]
plugins=ifupdown,keyfile

[ifupdown]
managed=true

# stop the service and remove cache
sudo systemctl stop NetworkManager
sudo rm -rf /var/lib/NetworkManager/*

# check if interface is up
sudo ip link set wlp0s20f3 up

# start the service
sudo systemctl start NetworkManager
```

## Install VSCode
- download the .deb package from [here](https://code.visualstudio.com/docs/setup/linux#_install-vs-code-on-linux)
```
apt install ./<file>.deb
```

## Install flatpak packages
```
flatpak install obsidian protonvpn
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
# then
nvim /usr/share/dbus-1/services/org.freedesktop.Notifications.service
# add these
[D-BUS Service]
Name=org.freedesktop.Notifications
Exec=/usr/lib/notification-daemon/notification-daemon
```

## Install Ueberzugpp to render images in st
- download from [here](https://software.opensuse.org/download.html?project=home%3Ajustkidding&package=ueberzugpp)
```
apt install ./ueberzugpp_<version_latest>_amd64.deb
```
- Or you can do this for Debian 13
```
echo 'deb http://download.opensuse.org/repositories/home:/justkidding/Debian_13/ /' | sudo tee /etc/apt/sources.list.d/home:justkidding.list
curl -fsSL https://download.opensuse.org/repositories/home:justkidding/Debian_13/Release.key | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/home_justkidding.gpg > /dev/null
apt update
apt install ueberzugpp
```

## Install lightdm
- make `~/.xinitrc` executable
- then copy `../linux_config/dwm.desktop` to `/usr/share/xsessions/`
- and don't forget to change which session lightdm loads when you login
```
apt install lightdm
chmod +x ~/.xinitrc
cp ~/dev/config/linux_config/dwm.desktop /usr/share/xsessions/
```


## Configure git credential manager
- download gcm first then run the following
    - [v2.6.1](https://github.com/git-ecosystem/git-credential-manager/releases/download/v2.6.1/gcm-linux_amd64.2.6.1.deb)
```
dpkg -i gcm-linux_amd64.2.6.1.deb 
```

### Set up git-cm
```
gpg --full-generate-key 
git config --global credential.credentialStore gpg
git config --global credential.helper manager
pass init "<type ur id here>"
```

### Set up pinentry for git-cm
- include `export GPG_TTY=$(tty)` in `.bashrc`
```
cp ~/dev/config/linux_config/gpg-agent.conf ~/.gnupg/
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

## Remove unnecessary packages
- with these packages, some applications like localsend and dolphin were slow to startup and would freeze (more like there would be a transparent window when they started)
- [see issue](https://github.com/flatpak/xdg-desktop-portal/issues/1032)
```
# apt purge xdg-desktop-portal-gtk xdg-desktop-portal-kde xdg-desktop-portal-lxqt
apt purge xdg-desktop-portal*
apt autoremove
```

## To install Tor browser
- download from [here](https://packages.debian.org/search?keywords=torbrowser-launcher)
    - [UK mirror: 0.3.7-3-amd64](http://ftp.uk.debian.org/debian/pool/contrib/t/torbrowser-launcher/torbrowser-launcher_0.3.7-3_amd64.deb)
```
# verify the hash
echo "<sha256 hash> <torbrowser>.deb" | sha256sum -c -

# install
apt install <torbrowser>.deb
```

## To update default applications
- change `~/.config/mimeapps.list` then
- or you can also use command `xdg-mime default nemo.desktop inode/directory` (this will make nemo the default file manager)
```sh
update-desktop-database $HOME/.local/share/applications/
```


