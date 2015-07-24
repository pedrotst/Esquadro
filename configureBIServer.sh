#/usr/sh
biserverdiretorio=$DIR_BI_SERVER
host=$HOST_MYSQL
port=$PORT_MYSQL
mysql -h $host -P $port -u root -proot < "$biserverdiretorio/biserver-ce/data/mysql5/create_jcr_mysql.sql"
mysql -h $host -P $port -u root -proot < "$biserverdiretorio/biserver-ce/data/mysql5/create_quartz_mysql.sql"
mysql -h $host -P $port -u root -proot < "$biserverdiretorio/biserver-ce/data/mysql5/create_repository_mysql.sql"


