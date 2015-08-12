#!/bin/sh
tmpFile=/tmp/libKeyfile
while read line; do
	echo $line>"$tmpFile";
	key=$(cut -d" " -f1 < "$tmpFile");
	packege=$(cut -d" " -f2 < "$tmpFile");
        if  apt-key list | grep  "$key">/dev/null;
        then
                echo "The $key of the packege: $packege is already added";
        else
                echo "In order to install the packege: $packege ,you must run the addKeys.sh";
        fi

	rm "$tmpFile"
done < keys
                

