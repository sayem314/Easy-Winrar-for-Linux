#!/bin/bash
#
# Easy Winrar for Linux
# v1.1
#

	#Detect architecture
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
	PREFIX="/usr/local"
	mkdir -p $PREFIX/bin
	mkdir -p $PREFIX/lib
	#Deleting any previous version
	rm -f $PREFIX/bin/rar
	rm -f $PREFIX/bin/unrar
	rm -f /etc/rarfiles.lst
	rm -f $PREFIX/lib/default.sfx	
	#Copying rar unrar
	cp rar unrar $(PREFIX)/bin
	cp rarfiles.lst /etc
	cp default.sfx $(PREFIX)/lib
	cd /tmp
	rm -rf rar
	rm -f rarlinux*
	echo "  Done :)"
	exit;
