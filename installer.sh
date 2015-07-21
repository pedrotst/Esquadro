#!/bin/sh


while read package; do
	if  dpkg -s "$package" 2>/dev/null | grep  "Status: install ok installed">/dev/null;
	then
		echo "$package is already installed";
	else
		echo "Installing $package\n";
		apt-get --yes --force-yes  install "$package";
	fi
done < packages
