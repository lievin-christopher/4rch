pkgname=4rch
pkgver=0.9
pkgrel=8
pkgdesc="Autoconfig new archlinux installation"
arch=('x86_64')
# Base
depends=('linux-hardened' 'linux-hardened-headers' 'linux-hardened-docs' 'grub' 'python' 'exfat-utils' 'ntfs-3g')
# Network
depends+=('nmap' 'gnu-netcat' 'openssh' 'openvpn' 'dnsmasq' 'wpa_supplicant' 'openssl' 'ntp')
# CLI
depends+=('zsh' 'oh-my-zsh-git' 'task' 'git' 'htop' 'ldm' 'micro'  'ranger' 'rsync' 'screen')
# UI
depends+=('screenfetch' 'xorg-xhost' 'xorg-xinit' 'alsa-utils' 'i3lock-color-git' 'scrot' 'python-requests' 'xorg-xrandr' 'polybar' 'dialog' 'redshift-minimal' 'dmenu2' 'feh' 'i3-gaps' 'i3blocks' 'light-git' 'xorg-server' 'xorg-server-common' 'compton')
# Fonts
depends+=('noto-fonts-cjk' 'nerd-fonts-hack')
# Virtualisation
depends+=('qemu' 'lxc' 'arch-install-scripts')
# GUI Apps
depends+=('filezilla' 'vlc' 'p7zip' 'ranger' 'rxvt-unicode-wcwidthcallback' 'rxvt-unicode-terminfo'  'urxvt-perls' 'firefox-developer-edition')
# Multimedia
depends+=('w3m' 'mpd' 'ffmpeg' 'ncmpcpp')
# Android
depends+=('android-file-transfer' 'android-udev' 'android-tools')
optdepends=('gtop' 'krita' 'megacmd' 'namebench' 'wps-office' 'wps-office-extension-french-dictionary')
source=(https://github.com/lievin-christopher/4rch/archive/master.zip)
sha512sums=('SKIP')

package() {
  ls $srcdir/4rch-master
  mkdir -p $pkgdir$HOME/
  mkdir -p $pkgdir/etc
  chmod 700 $pkgdir$HOME/
  # Install config files and directories
  rsync -av $srcdir/4rch-master/.local $pkgdir$HOME/
  rsync -av $srcdir/4rch-master/.config $pkgdir$HOME/
  chmod 700 $pkgdir$HOME/.config
  ## I3
  rsync -av $srcdir/4rch-master/.i3 $pkgdir$HOME/
  chmod 700 $pkgdir$HOME/.i3
  ## mpd + ncmpcpp
  mkdir -p $pkgdir/opt/mpd/playlists
  touch $pkgdir/opt/mpd/mpd.log $pkgdir/opt/mpd/mpd.db
  mkdir -p $pkgdir/opt/mpd/lyrics
  mkdir -p $pkgdir$HOME/Music
  rsync -av $srcdir/4rch-master/.ncmpcpp $pkgdir$HOME/
  ## Daily script
  cp $srcdir/4rch-master/Xdefaults $pkgdir$HOME/.Xdefaults
  cp $srcdir/4rch-master/.zshrc $pkgdir$HOME/.zshrc
  echo "exec i3" > $pkgdir$HOME/.xinitrc
  echo "#!/bin/bash" > $pkgdir$HOME/.xsession
  echo '''i3-msg "workspace 2, move workspace to output primary"
  i3-msg "workspace 3, move workspace to output primary"''' > $pkgdir$HOME/.xsession
  chmod u+x $pkgdir$HOME/.xsession
  chown -R $USER:users $pkgdir$HOME
  cat $srcdir/4rch-master/taskrc >> $HOME/.taskrc
  mkdir -p $pkgdir/etc/X11/xorg.conf.d/
  cp $srcdir/4rch-master/00-keyboard.conf $pkgdir/etc/X11/xorg.conf.d/00-keyboard.conf
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
	cp $srcdir/4rch-master/bepo.gkb /boot/grub/bepo.gkb
	echo "insmod keylayouts" >> /etc/grub.d/40_custom
	echo "keymap /boot/grub/bepo.gkb" >> /etc/grub.d/40_custom
	grub-mkconfig -o /boot/grub/grub.cfg
	systemctl enable mpd.service
	systemctl enable mpd.socket
	systemctl enable lxc-net.service
}