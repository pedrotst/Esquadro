#/usr/sh

if [ "$#" -eq 5 ];
then
	workDirectory=$1
	host_mysql=$2
	port_mysql=$3
	user_mysql=$4
	user_password=$5
	
else
	echo "It is needed 4 arguments" 
	exit 0;
fi


echo "Creating databases of BIserver..."


echo "Creating databases of BIserver..."

#Try create this tables
mysql -h $host_mysql -P $port_mysql -u root -proot < "$workDirectory/biserver-ce/data/mysql5/create_jcr_mysql.sql"
mysql -h $host_mysql -P $port_mysql -u root -proot < "$workDirectory/biserver-ce/data/mysql5/create_quartz_mysql.sql"
mysql -h $host_mysql -P $port_mysql -u root -proot < "$workDirectory/biserver-ce/data/mysql5/create_repository_mysql.sql"

echo "The Databases required was created!"

echo "Copy files required by biserver with right configuration..."

files_cfg="filesToConfigureMYSQL"

#Copy new files, with right configuration
cp "$files_cfg/context.xml" "$workDirectory/biserver-ce/tomcat/webapps/pentaho/META-INF/"
cp "$files_cfg/applicationContext-spring-security-hibernate.properties" "$workDirectory/biserver-ce/pentaho-solutions/system/"
cp "$files_cfg/hibernate-settings.xml" "$workDirectory/biserver-ce/pentaho-solutions/system/hibernate/"
cp "$files_cfg/mysql5.hibernate.cfg.xml" "$workDirectory/biserver-ce/pentaho-solutions/system/hibernate/"
cp "$files_cfg/quartz.properties" "$workDirectory/biserver-ce/pentaho-solutions/system/quartz/"
cp "$files_cfg/repository.xml" "$workDirectory/biserver-ce/pentaho-solutions/system/jackrabbit/"

echo "Copy success!"
