#!/bin/sh

./installKeys.sh

logFile=/tmp/esquadro/install.log

while read package; do
	if  dpkg -s "$package" 2>/dev/null | grep  "Status: install ok installed">/dev/null;
	then
		echo "$package is already installed";
	else
		echo "Installing $package\n";
		result=$(apt-get --yes --force-yes  install "$package" >>"$logFile");
        echo "This is the result: $result\n";
	fi
done < packages

workDirectory=""
if [ -d "$1" ]; then
    echo "The installation is going to use the directory $1"
    workDirectory=$1
else
    workDirectory="/usr/esquadro"
    echo "It is going to create the default directory in $workDirectory " 
    mkdir $workDirectory
    echo "The directory is created"
fi

./downloadFiles.sh $workDirectory
