# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=7

PYTHON_COMPAT=( python2_7 )

inherit cmake
CMAKE_BUILD_TYPE="Release"

DESCRIPTION="A joystick testing and configuration tool for Linux"
HOMEPAGE="https://jstest-gtk.gitlab.io/"

LICENSE="GPLv3"
SLOT="0"

if [[ "${PV}" == "9999" ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/Grumbel/jstest-gtk.git"
	KEYWORDS=""
else
	KEYWORDS="~amd64"
	SRC_URI="https://github.com/Grumbel/$(PN)/archive/refs/tags/v($PV).tar.gz -> ${P}.tar.bz2"
fi

RDEPEND="dev-libs/libsigc++
	dev-cpp/gtkmm"
DEPEND="${RDEPEND}
	dev-util/cmake"

src_prepare() {
	epatch "${FILESDIR}/find_data_dir.patch"
	cmake_src_prepare
}
src_install() {
	dobin "${CMAKE_BUILD_DIR}"/${PN}
	insinto /usr/share/${PN}
	doins -r "${S}"/data

	doicon ${S}/data/generic.png

	make_desktop_entry "${PN}" "${PN}" "generic" "Utility" "Path=/usr/share/${PN}"

}
