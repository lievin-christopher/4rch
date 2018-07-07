pkgname=4rch
pkgver=0.1
pkgrel=1
pkgdesc="Autoconfig new archlinux installation"
arch=('x86_64')
depends=('zsh' 'betterlockscreen' 'scrot' 'vlc' 'task' 'redshift-minimal' 'dmenu2' 'ffmpeg' 'feh' 'git' 'htop' 'i3-gaps' 'i3blocks' 'ldm' 'linux-hardened' 'linux-hardened-headers' 'linux-hardened-docs' 'micro' 'ncmpcpp' 'openssl' 'grub' 'otf-font-awesome-4' 'ttf-font-awesome' 'otf-hack' 'ttf-hack' 'p7zip' 'p7zip-gui' 'python' 'qemu' 'ranger' 'rsync' 'rxvt-unicode-pixbuf' 'rxvt-unicode-terminfo' 'screen' 'ttf-material-design-icons' 'urxvt-perls')
optdepends=('gtop' 'krita' 'megacmd' 'namebench' 'wps-office' 'wps-office-extension-french-dictionary')
source=(https://github.com/lievin-christopher/4rch.git)
sha512sums=('SKIP')
package() {
  ls $srcdir/4rch.git
  rsync -av $srcdir/config $pkgdir$HOME/.config
  cp $srcdir/Xdefaults $pkgdir$HOME/.Xdefaults
  echo "exec i3" > $pkgdir$HOME/.xinitrc
  echo "exec sudo ldm -d -u $USER" >> $pkgdir$HOME/.xsession
  
}
