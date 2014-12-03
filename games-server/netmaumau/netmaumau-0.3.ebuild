# Copyright 2014 Julian Ospald <hasufell@posteo.de>
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit autotools flag-o-matic eutils libtool vcs-snapshot

DESCRIPTION="Server for the popular card game Mau Mau"
HOMEPAGE="http://sourceforge.net/projects/netmaumau"
SRC_URI="https://github.com/velnias75/NetMauMau/archive/V${PV}.tar.gz -> ${P}-server.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc static-libs"

RDEPEND="
	>=dev-libs/popt-1.10
"
DEPEND="${RDEPEND}
	sys-apps/help2man
	virtual/pkgconfig
	doc? ( >=app-doc/doxygen-1.8.0 )
"

S=${WORKDIR}/${P}-server

src_prepare() {
	eautoreconf
}

src_configure() {
	append-cppflags -DNDEBUG

	econf \
		--enable-client \
		$(use_enable doc apidoc) \
		--enable-ai-name="Gentoo Hero"
		--docdir=/usr/share/doc/${PF}
}

src_install() {
	default
	prune_libtool_files
}

pkg_postinst() {
	elog "This is only the server part, you might want to install"
	elog "the client too:"
	elog "  games-board/netmaumau"
}

