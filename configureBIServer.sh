#/usr/sh

#BIServer is located in back folder
cd ../

#Set properties of user
host=$HOST_MYSQL
port=$PORT_MYSQL

echo "Creating databases of BIserver..."

#Try create this tables
mysql -h $host -P $port -u root -proot < "biserver-ce/data/mysql5/create_jcr_mysql.sql"
mysql -h $host -P $port -u root -proot < "biserver-ce/data/mysql5/create_quartz_mysql.sql"
mysql -h $host -P $port -u root -proot < "biserver-ce/data/mysql5/create_repository_mysql.sql"

echo "Finalized!"
