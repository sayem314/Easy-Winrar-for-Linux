#!/bin/bash
#
# Easy Winrar for Linux
# v1.6
#

CV="5.5.0"
DIR="/usr/local"

echo ""

# Detect architecture
if uname -m | grep -q 64; then
	echo "  Downloading Winrar $CV for 64bit"
	winrar="rarlinux-x64-$CV"
elif uname -m | grep -q 86; then
	echo "  Downloading Winrar $CV for 32bit"
	winrar="rarlinux-$CV"
else
	echo "  unsupported or unknown architecture"
	echo ""
	exit;
fi

# Download winrar
cd /tmp || exit
wget -q http://rarlab.com/rar/$winrar.tar.gz
tar -xzf rarlinux* && cd rar || exit

# Deleting any previous version
rm -f $DIR/bin/rar /usr/bin/rar /bin/rar
rm -f $DIR/bin/unrar /usr/bin/unrar /bin/unrar
rm -f /etc/rarfiles.lst
rm -f $DIR/lib/default.sfx /usr/lib/default.sfx /lib/default.sfx

# Copying rar unrar
cp rar unrar /bin
cp rarfiles.lst /etc
cp default.sfx /lib
cd /tmp || exit
rm -rf rar
rm -f rarlinux*
echo "  Done :)"
echo ""
exit;
