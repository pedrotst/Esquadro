#!/bin/bash

docker run --name mysqltest -e MYSQL_ROOT_PASSWORD=root -d mysql:5.6

export PORT_MYSQL=3306

export DIR_BI_SERVER=$PWD

export HOST_MYSQL=$(docker inspect mysqltest | grep "IPAddress" | cut -d"\"" -f4)

echo $PORT_MYSQL
echo $DIR_BI_SERVER
echo $HOST_MYSQL

#wait for mysql gets up 
sleep 30

../../configureBIServer.sh

mysql -P $PORT_MYSQL -h $HOST_MYSQL -u root -proot <<< "SELECT SCHEMA_NAME FROM INFORMATION_SCHEMA.SCHEMATA INTO OUTFILE '/tmp/dbs';"

sudo docker cp mysqltest:/tmp/dbs $PWD 

numdbs=$(egrep "hibernate|quartz|jackrabbit" dbs | wc -l)
expected=3

if [ $numdbs == $expected ]
then
    echo "Create bds is ok"
fi 

rm $PWD/dbs
docker stop mysqltest
docker rm mysqltest

