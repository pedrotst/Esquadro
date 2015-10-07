#!/bin/sh

###############################################
#
# This is the main script of instalation,
# to more information, see esquadro's wiki.
#
###############################################

# Basic informations to run this script
function help {
		echo "This script install and configure Esquadro and your dependencies"
		echo -e \\n "Arguments:"
		echo -e "-p \t Password of Mysql-server"
		echo -e "-d \t Directory where will be installed"
		echo -e "-h or --help \t This guide"
		exit 1
}

# Force instalation of wget
apt-get --yes --force-yes  install  wget

# Configure source code
./installKeys.sh

# Default file archieving instalation's log
LOG_FILE=/tmp/esquadro.install.log

# Default database informations
ROOT_PASSWORD="root"
HOST_DATABASE="localhost"
HOST_PORT="3306"
DATABASE_USER="root"
DATABASE_PASSWORD="root"

# Default instalation directory is /usr/esquadro
WORK_DIR=/usr/esquadro

while getopts ":d:p:h" option; do
	case $option in
		d) # Set directory
			WORK_DIR=$OPTARG
			;;
		p) # Set root password
			DATABASE_PASSWORD=$OPTARG
			;;
		h) # Simple manual
			help
			exit 1
			;;
		\?) #Argument invalid
			echo "Invalid option: -$OPTARG run --help" >&2
			exit 1
			;;
	esac
done

# @Deprecated why esquadro should install mysql?
#
# Creating a preconfigurating file to instalation of mysql
# sudo debconf-set-selections <<< "mysql-server mysql-server/root_password password $ROOT_PASSWORD"
# sudo debconf-set-selections <<< "mysql-server mysql-server/root_password_again password $ROOT_PASSWORD"

# Run installation!
#
# packages: is an file that have all dependencies needs to use esquadro.
# The follow while above percours packages file, installing your described packages
while read package; do
	if  dpkg -s "$package" 2>/dev/null | grep  "Status: Install Ok!">/dev/null;
	then
		echo "$package is already installed";
	else
		echo "Installing $package\n";
		RESULT=$(apt-get --yes --force-yes  install "$package" >>"$LOG_FILE");
        echo "This is the result: $RESULT\n";
	fi
done < packages

# Run other configuration scripts
# Set folder of esquadro with pentaho tools and transformations folder

# download pentaho data-integration and bi-server
./downloadFiles.sh $WORK_DIR

# Create an environment variable to set directory of runTransformation.sh
./configureTransformations/configureTransformations.sh $WORK_DIR

./configureBIServer.sh $WORK_DIR $HOST_DATABASE $HOST_PORT $DATABASE_USER $DATABASE_PASSWORD
