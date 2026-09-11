#!/bin/bash
#
# Easy WinRAR for Linux
# v2.0
# Downloads and installs the latest WinRAR (rar + unrar) from rarlab.com
#

set -u

BASE="https://www.rarlab.com"
PINNED="7.2.3" # fallback if the latest version cannot be auto-detected

msg() { printf '  %s\n' "$1"; }
die() { printf '  %s\n' "$1" >&2; exit 1; }

pretty() { # 723 -> 7.2.3
	local v=$1
	[ ${#v} -eq 3 ] && v="${v:0:1}.${v:1:1}.${v:2:1}"
	printf '%s' "$v"
}

fetch() { # print URL body, curl preferred, wget fallback
	if command -v curl >/dev/null 2>&1; then
		curl -fsSL "$1"
	elif command -v wget >/dev/null 2>&1; then
		wget -qO- "$1"
	else
		die "Need curl or wget to download files"
	fi
}

# root check
[ "$(id -u)" -eq 0 ] || die "Please run as root, e.g. pipe this script through sudo bash"

# rarlab publishes x86_64 Linux builds only
case "$(uname -m)" in
x86_64) ;;
*) die "Unsupported architecture: $(uname -m) (rarlab ships x86_64 Linux builds only)" ;;
esac

# resolve version: WINRAR_VERSION env override > auto-detect latest stable > pinned fallback
FVER="${WINRAR_VERSION:-}"
FVER="${FVER//./}"
if [ -z "$FVER" ]; then
	FVER=$(fetch "$BASE/download.htm" |
		grep -oE 'rarlinux-x64-[0-9]+\.tar\.gz' |
		sort -uV | tail -n1 |
		sed -E 's/.*x64-([0-9]+)\.tar\.gz/\1/')
fi
[ -n "$FVER" ] || FVER="${PINNED//./}"
CV=$(pretty "$FVER")
TARBALL="rarlinux-x64-$FVER.tar.gz"
msg "Downloading WinRAR $CV"

# download + extract inside a private temp dir, cleaned up on exit
TMP=$(mktemp -d) || die "Could not create a temp dir"
trap 'rm -rf "$TMP"' EXIT
fetch "$BASE/rar/$TARBALL" >"$TMP/$TARBALL" || die "Download failed: $BASE/rar/$TARBALL"
tar -xzf "$TMP/$TARBALL" -C "$TMP" || die "Extracting $TARBALL failed"
cd "$TMP/rar" || die "Unexpected archive layout"

# remove files written by pre-2.0 versions of this installer
rm -f /usr/bin/rar /bin/rar /lib/default.sfx

# install to /usr/local (never touches distro-managed /usr/bin, shadows any system unrar via PATH)
install -m 755 rar unrar /usr/local/bin/
install -m 644 rarfiles.lst /etc/
install -m 644 default.sfx /usr/local/lib/

msg "Done :) run: rar or unrar"
exit 0
