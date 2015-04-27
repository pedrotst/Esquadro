#!/bin/sh
while read key; do
        if  apt-key list | grep  "$key">/dev/null;
        then
                echo "$key is already added";
        else
                echo "In order to install the packege ,you must run the addKeys.sh";
        fi
done < keys
                

