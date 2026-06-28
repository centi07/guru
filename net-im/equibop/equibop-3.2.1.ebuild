# Distributed under the terms of the GNU General Public License v3

EAPI=8

DESCRIPTION="Equibop - a custom client for Discord"
HOMEPAGE="https://github.com/Equicord/Equibop"

ICON_NAME="org.equicord.equibop.png"
SRC_URI="
	https://github.com/Equicord/Equibop/releases/download/v${PV}/equibop-${PV}.tar.gz
	https://imgproxy.flathub.org/insecure/dpr:2/f:avif/q:100/rs:fit:128:128/aHR0cHM6Ly9kbC5mbGF0aHViLm9yZy9tZWRpYS9vcmcvZXF1aWNvcmQvZXF1aWJvcC85NzIwODAwNGEzNTc0MzlkZjJhOTQ1N2E0NTE1NTAxYS9pY29ucy8xMjh4MTI4L29yZy5lcXVpY29yZC5lcXVpYm9wLnBuZw -> ${ICON_NAME}
"

LICENSE="GPL-3" 
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE=""

src_compile() {
	:
}

src_install() {
	insinto /usr/share/equibop
	doins -r *

	fperms +x /usr/share/equibop/equibop

	dosym ../share/equibop/equibop /usr/bin/equibop

	doicon -s 128 "${DISTDIR}/${ICON_NAME}"

	make_desktop_entry equibop "Equibop" "org.equicord.equibop" "Network;InstantMessaging;"
}