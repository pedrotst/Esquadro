#/usr/sh

########################## ABOUT #############################
#
# This script configure BIServer with postgresql
#
##############################################################

# Try get 5 arguments to configure data integration, they
# are essential to run mysql, so if you don't entry with 5 arguments:
# YOU SHALL NOT PASS!

if [ "$#" -eq 5 ];
then
	# Directory where is installed Esquadro
	WORK_DIR=$1
	HOST_DB=$2
	PORT_DB=$3
	USER_DB=$4
	PASSWORD_DB=$5
else
	echo "It is needed 5 arguments... Please try again!"
	exit 0;
fi

# The follow scripts will create basic settings.
# The last sql will generate an basic schemma to an database OLAP
echo "Creating databases of BIserver..."
psql source_info -f $WORK_DIR/biserver-ce/data/postgresql/create_jcr_postgresql.sql
psql source_info -f $WORK_DIR/biserver-ce/data/postgresql/create_quartz_postgresql.sql
psql source_info -f $WORK_DIR/biserver-ce/data/postgresql/create_repository_postgresql.sql

echo "Database was created!"

echo "Copy files required by biserver with right configuration..."

# Copy new files, with right configuration!
# BIServer needs some settings to run with MYSQL, so the follow archives copy this
FILES_CONFIG="filesToConfigurePostgreSQL"

cp "$FILES_CONFIG/context.xml" "$WORK_DIR/biserver-ce/tomcat/webapps/pentaho/META-INF/"
cp "$FILES_CONFIG/applicationContext-spring-security-hibernate.properties" "$WORK_DIR/biserver-ce/pentaho-solutions/system/"
cp "$FILES_CONFIG/hibernate-settings.xml" "$WORK_DIR/biserver-ce/pentaho-solutions/system/hibernate/"
cp "$FILES_CONFIG/mysql5.hibernate.cfg.xml" "$WORK_DIR/biserver-ce/pentaho-solutions/system/hibernate/"
cp "$FILES_CONFIG/quartz.properties" "$WORK_DIR/biserver-ce/pentaho-solutions/system/quartz/"
cp "$FILES_CONFIG/repository.xml" "$WORK_DIR/biserver-ce/pentaho-solutions/system/jackrabbit/"

echo "Copy success!"
