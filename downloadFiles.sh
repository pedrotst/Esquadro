#!/bin/bash

#################################################
#
# This script reads the urls of pentaho,
# download links and extracts to esquadro folder
#
#################################################

#FIXME Do a test to check if unzip is installed
echo "Installing unzip to extract dataintegration..."

WORK_DIR=$1
if [ ! -d "$1"]; then
    echo -e "The download of pentaho files stoped \n"
    echo -e "Because the directory of installation does not exist\n"
fi

while IFS=' ' read -r filename url
  do
      #filename="$workDirectory/$filename"
  	echo "File to download - $filename"
  	echo "File url - $url"

  	# Download current file
  	wget -O	$filename $url

  	#Extract file
  	unzip $filename -d "$WORK_DIR"

  	#Remove zip
  	rm $filename -f

done < dependencies
