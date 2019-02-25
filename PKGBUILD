# Maintainer: Lievin Christopher <lievin.christopher@gmail.com>
pkgname=4rch
pkgver=0.9
pkgrel=9
pkgdesc="Autoconfig new archlinux installation"
arch=('x86_64')
license=('MIT')
source=(https://github.com/lievin-christopher/4rch/archive/master.zip)
sha512sums=('SKIP')
NoUpgrade=$HOME/.zshrc

# Base
depends=('linux-hardened' 'linux-hardened-headers' 'linux-hardened-docs' 'grub' 'python' 'exfat-utils' 'ntfs-3g')
# Network
depends+=('nmap' 'gnu-netcat' 'openssh' 'openvpn' 'dnsmasq' 'wpa_supplicant' 'openssl' 'ntp')
# CLI
depends+=('zsh' 'oh-my-zsh-git' 'task' 'git' 'htop' 'ldm' 'micro'  'ranger' 'rsync' 'screen')
# UI
depends+=('screenfetch' 'xorg-xhost' 'xorg-xinit' 'alsa-utils' 'i3lock-color-git' 'scrot' 'python-requests' 'xorg-xrandr' 'polybar' 'dialog' 'redshift-minimal' 'dmenu2' 'feh' 'i3-gaps' 'i3blocks' 'light' 'xorg-server' 'xorg-server-common' 'compton' 'dunst')
# Fonts
depends+=('noto-fonts-cjk' 'nerd-fonts-hack')
# Virtualisation
depends+=('qemu' 'lxc' 'arch-install-scripts')
# GUI Apps
depends+=('filezilla' 'vlc' 'p7zip' 'ranger' 'rxvt-unicode-intensityfix'  'urxvt-perls' 'urxvt-resize-font-git' 'firefox-developer-edition')
# Multimedia
depends+=('w3m' 'mpd' 'ffmpeg' 'ncmpcpp' 'mpc')
# Android
depends+=('android-file-transfer' 'android-udev' 'android-tools')
optdepends=('gtop' 'krita' 'namebench' 'wps-office' 'wps-office-extension-french-dictionary')

package() {
  ls $srcdir/4rch-master
  mkdir -p $pkgdir$HOME/
  mkdir -p $pkgdir/etc
  chmod 700 $pkgdir$HOME/
  # Install config files and directories
  rsync -av $srcdir/4rch-master/.local $pkgdir$HOME/
  rsync -av $srcdir/4rch-master/.config $pkgdir$HOME/
  chmod 700 $pkgdir$HOME/.config
  ## mpd + ncmpcpp
  mkdir -p $pkgdir/opt/mpd/playlists
  touch $pkgdir/opt/mpd/mpd.log $pkgdir/opt/mpd/mpd.db
  mkdir -p $pkgdir/opt/mpd/lyrics
  mkdir -p $pkgdir$HOME/Music
  rsync -av $srcdir/4rch-master/.ncmpcpp $pkgdir$HOME/
  ## Daily script
  install -m644 "$srcdir/4rch-master/.Xdefaults" -t "$pkgdir$HOME/.Xdefaults"
  install -m640 "$srcdir/4rch-master/.zshrc" -t "$pkgdir$HOME/.zshrc"
  install -m644 "$srcdir/4rch-master/.xinitrc" -t "$pkgdir$HOME/.xinitrc"
  install -m740 "$srcdir/4rch-master/.xsession" -t "$pkgdir$HOME/.xsession"
  install -m640 "$srcdir/4rch-master/.taskrc" -t "$pkgdir$HOME/.taskrc"
  chown -R $USER:users $pkgdir$HOME
  mkdir -p $pkgdir/etc/X11/xorg.conf.d/
  install -m644 "$srcdir/4rch-master/00-keyboard.conf" -t "$pkgdir/etc/X11/xorg.conf.d/00-keyboard.conf"
  install -m644 "$srcdir/4rch-master/dnsmasq.conf" -t "$pkgdir/etc/dnsmasq.conf"
  install -m644 "$srcdir/4rch-master/lxc-default" -t "$pkgdir/etc/lxc/default.conf"
  install -m644 "$srcdir/4rch-master/lxc-net" -t "$pkgdir/etc/default/lxc-net"
  dialog --create-rc $pkgdir$HOME/.dialogrc
  dialog --create-rc $pkgdir/etc/dialogrc
}

post_install() {
	echo -en "music_directory " > $pkgdir/etc/mpd.conf
	echo "$HOME/Music" >>  $pkgdir/etc/mpd.conf
	cat $srcdir/4rch-master/mpd.conf >>  $pkgdir/etc/mpd.conf
    sed --in-place=.pacsave 's/arch.pool.ntp.org/fr.pool.ntp.org iburst/'
	chown mpd /etc/mpd.conf
	chown -R mpd /opt/mpd
	install -m644 "$srcdir/4rch-master/bepo.gkb" "/boot/grub/bepo.gkb"
	echo "insmod keylayouts" >> /etc/grub.d/40_custom
	echo "keymap /boot/grub/bepo.gkb" >> /etc/grub.d/40_custom
	grub-mkconfig -o /boot/grub/grub.cfg
	systemctl enable mpd.service
	systemctl enable mpd.socket
	systemctl enable lxc-net.service
}