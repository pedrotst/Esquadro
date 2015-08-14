#/usr/sh

#FIXME Do a test to check if unzip is installed
echo "Installing unzip to extract dataintegration..."

workDirectory=""
if [ ! -d "$1"]; then
    echo "The download of pentaho files stoped \n"
    echo "because the directory of installation does not exist\n"
else
    workDirectory=$1
fi    

while IFS=' ' read -r filename url
do
    filename="$workDirectory/$filename"
	echo "File to download - $filename"
	echo "File url - $url"
    
	# Download current file
	wget -O	$filename $url

	#Extract file
	unzip $filename

	#Remove zip
	rm $filename -f

done < dependencies
