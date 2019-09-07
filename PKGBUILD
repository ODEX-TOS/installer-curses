# Maintainer: Tom Meyers tom@odex.be
pkgname=installer-cli
pkgver=r16.5e98716
pkgrel=1
pkgdesc="CLI interface for installing TOS"
arch=(any)
url="https://github.com/ODEX-TOS/installer-curses"
_reponame="installer-curses"
license=('GPL')

source=(
"git+https://github.com/ODEX-TOS/installer-curses.git"
)
md5sums=('SKIP')
depends=('installer-backend' 'dialog' 'bash')
makedepends=('git')

pkgver() {
  cd "$srcdir/$_reponame"
  printf "r%s.%s" "$(git rev-list --count HEAD)" "$(git rev-parse --short HEAD)"
}


build() {
    return 0;
}

package() {
        cd "$srcdir/$_reponame"
        install -Dm755 install.sh "$pkgdir"/usr/bin/tos-cli-install
        install -Dm755 dialog.sh "$pkgdir"/usr/bin/dialog.sh
        mkdir -p "$pkgdir"/usr/share/tos-cli-installer
        for file in * ; do
            install -Dm755 "$file" "$pkgdir"/usr/share/tos-cli-installer/"$file"
        done
}
