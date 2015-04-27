#!/bin/sh
while read line; do
	echo $line>/tmp/testAddKeyfile;
	key=$(cut -d" " -f1 < /tmp/file);
	packege=$(cut -d" " -f2 < /tmp/file);
        if  apt-key list | grep  "$key">/dev/null;
        then
                echo "The $key of the packege: $packege is already added";
        else
                echo "In order to install the packege: $packege ,you must run the addKeys.sh";
        fi

	rm /tmp/testAddKeyfile;
done < keys
                

