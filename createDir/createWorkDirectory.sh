#!/bin/sh

workDirectory=""
directoryUsed=0

if [ -n "$1" ] && [ -d "$1" ]; then
    echo "The installation is going to use the directory $1"
    workDirectory=$1
    directoryUsed=1
elif [ -n "$1" ]  && [ ! -d "$1" ]; then
    workDirectory=$1
    
fi


if [ ! -n "$1" ]; then 
    workDirectory="/usr/esquadro"
    if [ -d "$workDirectory" ]; then
        echo "The default directory already exitis"
        echo "Do you want to continue:[yes|no] "
        read option
        if [ "$option" = "yes" ];
        then
            echo "It is going to use a directory that already has been used" 
            directoryUsed=1
        else
            echo "The installation is going to be aborted"
            exit 0;
        fi 
    fi
    echo "The default directory is $workDirectory " 
fi

if [ $directoryUsed -eq 0 ]; then
    mkdir $workDirectory 2> /tmp/error.esquadro.log
    result=$(cat /tmp/error.esquadro.log)
    echo "$result"
    if [ ! -n "$result" ]; then
        echo "The directory was created"
    else
        echo "The directory cannot be created";
        exit 1; 
    fi
fi

