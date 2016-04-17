#!/bin/bash
#
# Easy Winrar for Linux
# v1.4
#

	#Detect architecture
	echo ""
	if [ -n "$(uname -m | grep 64)" ]; then
		echo "  Downloading Winrar 5.3.0 for 64bit"
		winrar="rarlinux-x64-5.3.0.tar.gz"
	elif [ -n "$(uname -m | grep 86)" ]; then
		echo "  Downloading Winrar 5.3.0 for 32bit"
		winrar="rarlinux-5.3.0.tar.gz"
	else
		echo "  unsupported or unknown architecture"
		echo ""
		exit;
	fi
	cd /tmp
	wget -q http://rarlab.com/rar/$winrar
	tar xzf rarlinux*
	cd rar
	dir="/usr/local"
	#Deleting any previous version
	rm -f $dir/bin/rar /usr/bin/rar
	rm -f $dir/bin/unrar /usr/bin/unrar
	rm -f /etc/rarfiles.lst
	rm -f $dir/lib/default.sfx /usr/lib/default.sfx
	#Copying rar unrar
	cp rar unrar /usr/bin
	cp rarfiles.lst /etc
	cp default.sfx /usr/lib
	cd /tmp
	rm -rf rar
	rm -f rarlinux*
	echo "  Done :)"
	echo ""
	exit;
