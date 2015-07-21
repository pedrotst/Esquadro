#/usr/sh

mysql -u root -p root < ../biserver-ce/data/mysql5/create_jcr_mysql.sql
mysql -u root -p root < ../biserver-ce/data/mysql5/create_quartz_mysql.sql
mysql -u root -p root < ../biserver-ce/data/mysql5/create_repository_mysql.sql


