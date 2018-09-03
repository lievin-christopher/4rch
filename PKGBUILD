pkgname=4rch
pkgver=0.7
pkgrel=1
pkgdesc="Autoconfig new archlinux installation"
arch=('x86_64')
depends=('openssh' 'openvpn' 'dnsmasq' 'wpa_supplicant' 'zsh' 'oh-my-zsh-git' 'task' 'git' 'htop' 'ldm' 'micro' 'openssl' 'ranger' 'rsync' 'screen')
# Base
depends=('linux-hardened' 'linux-hardened-headers' 'linux-hardened-docs' 'grub' 'python')
# UI
depends+=('alsa-utils' 'xorg-xbacklight' 'i3lock-color-git' 'scrot' 'python-requests' 'xorg-xrandr' 'polybar' 'dialog' 'redshift-minimal' 'dmenu2' 'feh' 'i3-gaps' 'i3blocks')
# Fonts
depends+=('noto-fonts-cjk' 'otf-font-awesome-4' 'ttf-font-awesome' 'ttf-hack' 'ttf-material-design-icons')
# Virtualisation
depends+=('qemu' 'lxc' 'arch-install-scripts')
# GUI Apps
depends+=('filezilla' 'vlc' 'p7zip' 'p7zip-gui' 'ranger' 'rxvt-unicode-pixbuf' 'rxvt-unicode-terminfo' 'urxvt-perls' 'firefox-developer-edition')
# MULTIMEDIA
depends+=('w3m' 'mpd' 'ffmpeg' 'ncmpcpp')

optdepends=('gtop' 'krita' 'megacmd' 'namebench' 'wps-office' 'wps-office-extension-french-dictionary')
source=(https://github.com/lievin-christopher/4rch/archive/master.zip)
sha512sums=('SKIP')

package() {
  ls $srcdir/4rch-master
  mkdir -p $pkgdir$HOME/
  mkdir -p $pkgdir/etc
  chmod 700 $pkgdir$HOME/
  # Install config files and directories
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
  echo 'exec sudo ip link set down $WIRELESS' >> $pkgdir$HOME/.xsession
  echo "exec sudo ldm -d -u $USER" >> $pkgdir$HOME/.xsession
  chmod u+x $pkgdir$HOME/.xsession
  dialog --create-rc $pkgdir$HOME/.dialogrc
  dialog --create-rc $pkgdir/etc/dialogrc
  chown -R $USER:users $pkgdir$HOME
}

post_install() {
	echo "music_directory		'$HOME/Music'\n" >  $pkgdir/etc/mpd.conf
	cat $srcdir/4rch-master/mpd.conf >>  $pkgdir/etc/mpd.conf
	chown mpd /etc/mpd.conf
	systemctl enable mpd.service
	systemctl enable mpd.socket
	systemctl enable lxc-net.service
	systemctl enable dhcpcd.service
}