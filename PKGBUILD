# Maintainer: Lievin Christopher <lievin.christopher@gmail.com>
pkgname=4rch
pkgver=1.5
pkgrel=0
pkgdesc="Autoconfig new archlinux installation"
arch=('x86_64')
license=('MIT')
source=(https://github.com/lievin-christopher/4rch/archive/master.zip)
sha512sums=('SKIP')
NoUpgrade=$HOME/.zshrc
backup=(
        "${HOME:1}/.config"
        "${HOME:1}/.ncmpcpp/config"
        "${HOME:1}/.dialogrc"
        "${HOME:1}/.taskrc"
        "${HOME:1}/.Xdefaults"
        "${HOME:1}/.xinitrc"
        "${HOME:1}/.xsession"
        "etc/default/lxc-net"
        "etc/lxc/default.conf"
        "etc/X11/xorg.conf.d/00-keyboard.conf"
        "etc/dnsmasq.conf"
        "etc/dialogrc"
       )

# Base
depends=('linux-hardened' 'linux-hardened-headers' 'linux-hardened-docs' 'grub' 'python' 'exfat-utils' 'ntfs-3g')
# Network
depends+=('nmap' 'gnu-netcat' 'openssh' 'dnsmasq' 'wpa_supplicant' 'openssl' 'ntp')
# CLI
depends+=('bash-completion' 'zsh' 'zsh-syntax-highlighting' 'task' 'git' 'htop' 'iftop' 'micro'  'ranger' 'rsync' 'screen')
depends+=('oh-my-zsh-git') #AUR
# UI
## X11
depends+=('xorg-xhost' 'xorg-xinit' 'scrot' 'xorg-xrandr' 'polybar' 'feh' 'i3-gaps'  'xorg-server' 'xorg-server-common' 'picom' 'xclip' 'bemenu-x11')
depends+=('i3lock-color-git' 'redshift-minimal') #AUR
## Universal
depends+=('screenfetch' 'pipewire' 'pipewire-audio' 'pipewire-pulse' 'wireplumber' 'python-requests' 'dialog' 'light' 'dunst')
# Fonts
depends+=('ttf-hack-nerd' 'noto-fonts' 'noto-fonts-cjk' 'noto-fonts-emoji')
# Virtualisation
depends+=('qemu' 'lxc' 'arch-install-scripts')
# GUI Apps
depends+=('vlc' 'p7zip' 'ranger'  'rxvt-unicode-terminfo' 'alacritty' 'firefox-developer-edition')
# Multimedia
depends+=('w3m' 'mpd' 'ffmpeg' 'ncmpcpp' 'mpc')
# Android
depends+=('android-file-transfer' 'android-udev' 'android-tools')
# Optional packages
## Network
optdepends=('openvpn' 'wireguard-tools')
## CLI
optdepends+=('bat' 'gtop' 'ldm')
## GUI
optdepends+=('filezilla')
### Office
optdepends+=('wps-office')
### Images
optdepends+=('krita')
## Old Urxvt Variant
optdepends+=('rxvt-unicode-patched-with-scrolling' 'urxvt-perls' 'urxvt-resize-font-git')

package() {
  ls $srcdir/4rch-master
  mkdir -p $pkgdir$HOME/
  mkdir -p $pkgdir/etc/{lxc,default}
  chmod 700 $pkgdir$HOME/
  # Install config files and directories
  rsync -av $srcdir/4rch-master/.config $pkgdir$HOME/
  chmod 700 $pkgdir$HOME/.config
  rsync -av $srcdir/4rch-master/.local $pkgdir$HOME/
  chmod 700 $pkgdir$HOME/.local
  ## mpd + ncmpcpp
  mkdir -p $pkgdir/opt/mpd/playlists
  touch $pkgdir/opt/mpd/mpd.log $pkgdir/opt/mpd/mpd.db
  mkdir -p $pkgdir/opt/mpd/lyrics
  mkdir -p $pkgdir$HOME/Music
  rsync -av $srcdir/4rch-master/.ncmpcpp $pkgdir$HOME/
  ## Daily script
  install -m644 "$srcdir/4rch-master/.Xdefaults" -t "$pkgdir$HOME/"
  install -m640 "$srcdir/4rch-master/.zshrc" -t "$pkgdir$HOME/"
  install -m644 "$srcdir/4rch-master/.xinitrc" -t "$pkgdir$HOME/"
  install -m740 "$srcdir/4rch-master/.xsession" -t "$pkgdir$HOME/"
  install -m640 "$srcdir/4rch-master/.taskrc" -t "$pkgdir$HOME/"
  chown -R $USER:users $pkgdir$HOME
  mkdir -p $pkgdir/etc/X11/xorg.conf.d/
  install -m644 "$srcdir/4rch-master/00-keyboard.conf" -t "$pkgdir/etc/X11/xorg.conf.d/"
  install -m644 "$srcdir/4rch-master/dnsmasq.conf" -t "$pkgdir/etc/"
  install -m644 "$srcdir/4rch-master/default.conf" -t "$pkgdir/etc/lxc/"
  install -m644 "$srcdir/4rch-master/lxc-net" -t "$pkgdir/etc/default/"
  dialog --create-rc $pkgdir$HOME/.dialogrc
  dialog --create-rc $pkgdir/etc/dialogrc
}

post_install() {
	echo -en "music_directory " > $pkgdir/etc/mpd.conf
	echo "\"$HOME/Music\"" >>  $pkgdir/etc/mpd.conf
	cat $srcdir/4rch-master/mpd.conf >>  $pkgdir/etc/mpd.conf
    sed --in-place=.pacsave 's/arch.pool.ntp.org/fr.pool.ntp.org iburst/' $pkgdir/etc/ntp.conf 
	chown mpd /etc/mpd.conf
	chown -R mpd /opt/mpd
	install -m644 "$srcdir/4rch-master/bepo.gkb" "/boot/grub/bepo.gkb"
	install -m644 "$srcdir/4rch-master/grub" "/etc/default/grub"
	echo "insmod keylayouts" >> /etc/grub.d/40_custom
	echo "keymap /boot/grub/bepo.gkb" >> /etc/grub.d/40_custom
	grub-mkconfig -o /boot/grub/grub.cfg
	install -m600 "$srcdir/4rch-master/iftop" "/etc/sudoers.d/iftop"
	systemctl enable mpd.service
	systemctl enable mpd.socket
	systemctl enable lxc-net.service
	systemctl enable ntpd.service
}
