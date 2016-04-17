#!/bin/bash
#
# Easy Winrar for Linux
# v1.2
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
	mkdir -p $dir/bin
	mkdir -p $dir/lib
	#Deleting any previous version
	rm -f $dir/bin/rar
	rm -f $dir/bin/unrar
	rm -f /etc/rarfiles.lst
	rm -f $dir/lib/default.sfx
	
	rm -f /bin/rar
	rm -f /bin/unrar
	rm -f /etc/rarfiles.lst
	rm -f /lib/default.sfx
	#Copying rar unrar
	cp rar unrar $dir/bin
	cp rarfiles.lst /etc
	cp default.sfx $dir/lib
	cd /tmp
	rm -rf rar
	rm -f rarlinux*
	echo "  Done :)"
	echo ""
	exit;
