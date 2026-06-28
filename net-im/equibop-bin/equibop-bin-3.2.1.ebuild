# Copyright 2024-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop xdg

DESCRIPTION="A custom Discord desktop app with Equicord pre-installed (binary release)"
HOMEPAGE="https://github.com/Equicord/Equibop"
SRC_URI="
	https://raw.githubusercontent.com/Equicord/Equibop/v${PV}/static/icon.png -> ${PN}-icon.png
	amd64? ( ${HOMEPAGE}/releases/download/v${PV}/equibop-${PV}.tar.gz -> ${P}-x86_64.tar.gz )
	arm64? ( ${HOMEPAGE}/releases/download/v${PV}/equibop-${PV}-arm64.tar.gz -> ${P}-aarch64.tar.gz )
"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~arm64"

S="${WORKDIR}/equibop-${PV}"

RDEPEND="
	dev-apps/electron:40
"
DEPEND="${RDEPEND}"

src_unpack() {
	default
}

src_prepare() {
	default
	
	cat <<- 'EOF' > "${T}/equibop.sh"
		#!/bin/sh
		exec env ELECTRON_OZONE_PLATFORM_HINT=auto /usr/bin/electron40 /usr/lib/equibop/app.asar "$@"
	EOF
}

src_install() {
	exeinto /usr/bin
	newexe "${T}/equibop.sh" equibop

	insinto /usr/lib/equibop
	doins resources/app.asar
	doins resources/app-update.yml
	doins -r resources/arrpc

	newicon "${DISTDIR}/${PN}-icon.png" equibop.png

	make_desktop_entry "equibop %U" "Equibop" "equibop" "Network;InstantMessaging;Chat;" "MimeType=x-scheme-handler/discord;\nStartupWMClass=equibop"
}