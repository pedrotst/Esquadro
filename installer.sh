#!/bin/sh


while read packege; do
	if  dpkg -s "$packege" 2>/dev/null | grep  "Status: install ok installed">/dev/null;
	then
		echo "$packege is already installed";
	else
		echo "Installing $packege\n";
		apt-get --yes --force-yes  install "$packege";
	fi
done < packeges
