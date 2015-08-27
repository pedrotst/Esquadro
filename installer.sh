#!/bin/sh

apt-get --yes --force-yes  install  wget


#configure mysql root password
root_password="root"
sudo debconf-set-selections <<< "mysql-server mysql-server/root_password password $root_password"
sudo debconf-set-selections <<< "mysql-server mysql-server/root_password_again password $root_password"
./installKeys.sh

logFile=/tmp/esquadro.install.log

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
if [ -n "$1" ];
then
    ./createDir/createWorkDirectory.sh "$1"
    workDirectory=$1
else 
    ./createDir/createWorkDirectory.sh
    workDirectory="/usr/esquadro"
fi

./downloadFiles.sh "$workDirectory"
./configureBIServer.sh "$workDirectory" "localhost" "3306" "root" "$root_password"
