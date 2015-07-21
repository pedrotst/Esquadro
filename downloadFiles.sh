#/usr/sh

#FIXME Do a test to check if unzip is installed
echo "Installing unzip to extract dataintegration..."

apt-get install unzip

#back to root of Esquadro
cd ../

while IFS=' ' read -r filename url
do
	echo "File to download - $filename"
	echo "File url - $url"

	# Download current file
	wget -O	$filename $url

	#Extract file
	unzip $filename

	#Remove zip
	rm $filename -f

done < scripts/dependencies
