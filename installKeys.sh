# It is going to download the keys from repositories of some dependencies:
# Analizo and R language

pathToSourceList="/etc/apt/sources.list"

# Adding repositories into source list

echo "\n">>"$pathToSourceList"
echo "#The Analizo repository to download, see analizo.org">>"$pathToSourceList"
echo "deb http://www.analizo.org/download/ ./">>"$pathToSourceList"
echo "deb-src http://www.analizo.org/download/ ./">>"$pathToSourceList"

echo "#The R language repository">>"$pathToSourceList"
echo "deb http://www.vps.fmvz.usp.br/CRAN/bin/linux/ubuntu trusty/">>"$pathToSourceList"

# To download in ubuntu, because it is not official

apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E084DAB9

wget -O - http://www.analizo.org/download/signing-key.asc | apt-key add -
