TERMUX_PKG_HOMEPAGE=https://www.ppsspp.org
TERMUX_PKG_DESCRIPTION="A PSP emulator"
TERMUX_PKG_LICENSE="GPL-2.0"
TERMUX_PKG_LICENSE_FILE="LICENSE.TXT"
TERMUX_PKG_MAINTAINER="@termux-user-repository"
TERMUX_PKG_VERSION="1.19.3"
TERMUX_PKG_SRCURL=git+https://github.com/hrydgard/ppsspp
TERMUX_PKG_GIT_BRANCH="v${TERMUX_PKG_VERSION}"
TERMUX_PKG_DEPENDS="ffmpeg, libc++, libpng, libsnappy, libzip, sdl3, sdl3-ttf, zlib"
TERMUX_PKG_BUILD_DEPENDS="vulkan-headers"
TERMUX_PKG_DEPENDS="libcurl, libpng, miniupnpc, zlib, libzip, glew, libsnappy, ffmpeg, libcpufeatures, rapidjson, sdl2, sdl2-ttf, fontconfig"
TERMUX_PKG_BUILD_DEPENDS="mesa-dev, libglvnd-dev, vulkan-headers, rapidjson, spirv-headers, spirv-tools"

# USE_SYSTEM_FFMPEG: the bundled ffmpeg archives are glibc builds and
#   won't link against Bionic (undefined __isoc99_sscanf, fcntl64).
# USING_GLES2=OFF: the GLES path pulls in EGL calls that aren't
#   available here; the desktop GL and Vulkan paths both work.
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
-DUSE_SYSTEM_FFMPEG=ON
-DUSE_SYSTEM_LIBZIP=ON
-DUSE_SYSTEM_SNAPPY=ON
-DUSING_GLES2=OFF
-DUSING_QT_UI=OFF
-DHEADLESS=OFF
"

termux_step_post_make_install() {
	install -Dm700 "$TERMUX_PKG_BUILDDIR/PPSSPPSDL" \
		"$TERMUX_PREFIX/bin/PPSSPPSDL"

	# PPSSPP looks for assets/ relative to its own binary.
	mkdir -p "$TERMUX_PREFIX/share/ppsspp"
	cp -r "$TERMUX_PKG_BUILDDIR/assets" "$TERMUX_PREFIX/share/ppsspp/"
}
