pkgname=dnsupdater
pkgrel=1
pkgver=20221106
pkgdesc="PDNS DNS updater"
arch=(x86_64)
url=""
license=('GPL')
source=('dnsupdater.service' 'dnsupdater.timer' 'dnsupdater.sh' "dnsupdater.conf")
sha1sums=('81f639d1890cd4f641a37aa0522c207365f77f3d'
          '334d13bea8efa4d3681274747f3327f43671ee2e'
          '81c4650fbbfd1463f317def5bffd5aa25a8a3a85'
          'da9b02fc99579bccc73f0566d4cd7a60c3e0c842')
depends=('bash' 'curl')
makedepends=()
provides=('dnsupdater')
conflicts=('dnsupdater')
backup=('etc/dnsupdater.conf')


package() {
    install -D -m755 ${srcdir}/dnsupdater.service ${pkgdir}/usr/lib/systemd/system/dnsupdater.service
    install -D -m755 ${srcdir}/dnsupdater.timer ${pkgdir}/usr/lib/systemd/system/dnsupdater.timer
    install -D -m755 ${srcdir}/dnsupdater.sh ${pkgdir}/usr/bin/dnsupdater.sh
    install -D -m644 ${srcdir}/dnsupdater.conf ${pkgdir}/etc/dnsupdater.conf
}
