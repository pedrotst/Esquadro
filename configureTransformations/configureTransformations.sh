#!/bin/bash

if [ ! -n "$1" ] && [ ! -n "$2" ]
then
    echo "It needs two argument"
    exit
fi
workDirectory="$1"
echo $workDirectory
cp -r "$2" "$workDirectory"

sed -i "/job=\"job.kjb\"/c\job=\"$workDirectory/transformations/job.kjb\"" "$workDirectory/transformations/runTransformation.sh"


sed -i "/pentahoDirectory=\"needtoalter\"/c\pentahoDirectory=\"$workDirectory/data-integration/kitchen.sh\"" "$workDirectory/transformations/runTransformation.sh"
