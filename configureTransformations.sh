#!/bin/bash

if [ ! -n "$1" ] && [ ! -n "$2" ]
then
    echo "It needs two argument"
    exit
fi

WORK_DIR="$1"

echo $WORK_DIR

cp -r "$2" "$WORK_DIR"

sed -i "/job=\"job.kjb\"/c\job=\"$WORK_DIR/transformations/job.kjb\"" "$WORK_DIR/transformations/runTransformation.sh"

sed -i "/pentahoDirectory=\"needtoalter\"/c\pentahoDirectory=\"$WORK_DIR/data-integration/kitchen.sh\"" "$WORK_DIR/transformations/runTransformation.sh"
