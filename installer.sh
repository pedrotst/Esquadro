#!/bin/sh


while read package; do
	if  dpkg -s "$package" 2>/dev/null | grep  "Status: install ok installed">/dev/null;
	then
		echo "$package is already installed";
	else
		echo "Installing $package\n";
		result=$(apt-get --yes --force-yes  install "$package");
        echo "$result\n";
	fi
done < packages
