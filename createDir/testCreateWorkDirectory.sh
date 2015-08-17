#!/bin/sh

workDirectory="/tmp/esquadro_teste/"
/home/gustavo/Documents/projetoHilmer/esquadro/createDir/createWorkDirectory.sh "$workDirectory"
if [ -d "$workDirectory" ]; then    
    echo "Create Sucesseful"
    rm -r "$workDirectory"
else
    echo "It was not created"

fi
