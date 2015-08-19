#!/bin/sh

workDirectory="/tmp/esquadro_teste/"
./createWorkDirectory.sh $workDirectory
if [ -d "$workDirectory" ]; then    
    echo "Create Sucesseful"
    rm -r "$workDirectory"
else
    echo "It was not created"

fi

workDirectory="/tmp/esquadro_teste/"
./createWorkDirectory.sh $workDirectory
result=$(./createWorkDirectory.sh $workDirectory)
echo "Result: $result"
if [ "$result" = "The installation is going to use the directory /tmp/esquadro_teste/" ] && [ -d "$workDirectory"  ]; 
then    
    echo "Create Sucesseful"
else
    echo "It was not created"

fi

rm -r "$workDirectory"

workDirectory="/usr/esquadro/"
./createWorkDirectory.sh 
if [ -d "$workDirectory" ]; then    
    echo "Create Sucesseful"
    rm -r "$workDirectory"
else
    echo "It was not created"

fi
