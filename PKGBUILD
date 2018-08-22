pkgname=4rch
pkgver=0.2
pkgrel=1
pkgdesc="Autoconfig new archlinux installation"
arch=('x86_64')
depends=('zsh' 'betterlockscreen' 'scrot' 'vlc' 'python-requests' 'xorg-xrandr' 'polybar' 'oh-my-zsh-git' 'dialog' 'mpd' 'task' 'redshift-minimal' 'dmenu2' 'ffmpeg' 'feh' 'git' 'htop' 'i3-gaps' 'i3blocks' 'ldm' 'linux-hardened' 'linux-hardened-headers' 'linux-hardened-docs' 'micro' 'ncmpcpp' 'openssl' 'grub' 'otf-font-awesome-4' 'ttf-font-awesome' 'ttf-hack' 'p7zip' 'p7zip-gui' 'python' 'qemu' 'ranger' 'rsync' 'rxvt-unicode-pixbuf' 'rxvt-unicode-terminfo' 'screen' 'ttf-material-design-icons' 'urxvt-perls' 'firefox-developer-edition' 'lxc' 'arch-install-scripts')
optdepends=('gtop' 'krita' 'megacmd' 'namebench' 'wps-office' 'wps-office-extension-french-dictionary')
source=(https://github.com/lievin-christopher/4rch/archive/master.zip)
sha512sums=('SKIP')

package() {
  ls $srcdir/4rch-master
  mkdir -p $pkgdir$HOME/
  chmod 711 $pkgdir$HOME/
  # Install config files and directories
  rsync -av $srcdir/4rch-master/config $pkgdir$HOME/.config
  chmod 700 $pkgdir$HOME/.config
  rsync -av $srcdir/4rch-master/i3 $pkgdir$HOME/.i3
  chmod 700 $pkgdir$HOME/.i3
  mkdir -p $pkgdir$HOME/.mpd/playlists
  touch $pkgdir$HOME/.mpd/mpd.log $pkgdir$HOME/.mpd/mpd.db
  mkdir -p $pkgdir$HOME/.lyrics
  mkdir -p $pkgdir$HOME/Musique
  rsync -av $srcdir/4rch-master/ncmpcpp $pkgdir$HOME/.ncmpcpp
  cp $srcdir/4rch-master/Xdefaults $pkgdir$HOME/.Xdefaults
  echo "exec i3" > $pkgdir$HOME/.xinitrc
  echo "#!/bin/bash" >> $pkgdir$HOME/.xsession
  echo "exec sudo netctl start eno1" >> $pkgdir$HOME/.xsession
  echo "exec sudo ldm -d -u $USER" >> $pkgdir$HOME/.xsession  
  chown -R $USER:users $pkgdir$HOME
}
