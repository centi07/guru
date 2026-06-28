# Copyright 2024-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop xdg

DESCRIPTION="Equibop is a custom Discord App aiming to give you better performance"
HOMEPAGE="https://github.com/Equicord/Equibop"
SRC_URI="https://github.com/Equicord/Equibop/releases/download/v${PV}/equibop-${PV}-linux-x64.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

S="${WORKDIR}"

RDEPEND="
	dev-libs/glib:2
	x11-libs/gtk+:3
	x11-libs/libnotify
	x11-libs/libX11
	x11-libs/libXcomposite
	x11-libs/libXcursor
	x11-libs/libXdamage
	x11-libs/libXext
	x11-libs/libXfixes
	x11-libs/libXi
	x11-libs/libXrandr
	x11-libs/libXrender
	x11-libs/libXtst
	x11-libs/libxcb
	x11-libs/libXScrnSaver
	dev-libs/nss
	dev-libs/nspr
	media-libs/alsa-lib
"
DEPEND="${RDEPEND}"

src_prepare() {
	default
}

src_install() {
	insinto /usr/share/equibop
	doins -r *

	dodir /usr/bin
	dosym ../share/equibop/equibop /usr/bin/equibop

	fperms +x /usr/share/equibop/equibop
	if [[ -f "${ED}/usr/share/equibop/chrome-sandbox" ]]; then
		fperms 4755 /usr/share/equibop/chrome-sandbox
	fi

	if [[ -f "equibop.desktop" ]]; then
		newmenu equibop.desktop equibop.desktop
	fi
}