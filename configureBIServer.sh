#/usr/sh

#BIServer is located in back folder

#Set properties of user
host=$HOST_MYSQL
port=$PORT_MYSQL

echo "Creating databases of BIserver..."

#Try create this tables
mysql -h $host -P $port -u root -proot < "biserver-ce/data/mysql5/create_jcr_mysql.sql"
mysql -h $host -P $port -u root -proot < "biserver-ce/data/mysql5/create_quartz_mysql.sql"
mysql -h $host -P $port -u root -proot < "biserver-ce/data/mysql5/create_repository_mysql.sql"

echo "The Databases required was created!"

echo "Copy files required by biserver with right configuration..."

files_cfg="scripts/filesToConfigureMYSQL/"

#Copy new files, with right configuration
cp "$files_cfg/context.xml" "/biserver-ce/tomcat/webapps/pentaho/META-INF/"
cp "$files_cfg/applicationContext-spring-security-hibernate.properties" "/biserver-ce/pentaho-solutions/system/"
cp "$files_cfg/hibernate-settings.xml" "/biserver-ce/pentaho-solutions/system/hibernate/"
cp "$files_cfg/mysql5.hibernate.cfg.xml" "/biserver-ce/pentaho-solutions/system/hibernate/"
cp "$files_cfg/quartz.properties" "/biserver-ce/pentaho-solutions/system/quartz/"
cp "$files_cfg/repository.xml" "biserver-ce/pentaho-solutions/system/jackrabbit/"

echo "Copy success!"
