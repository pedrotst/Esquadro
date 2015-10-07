#!/bin/bash

#######################################################################################
#
# IMPORTANT!!!
# 
# This script will change the variable $JOB_FILE which belongs to runTransformation.sh,
# installed by default in /usr/esquadro/transformations/. So this script only is
# necessary if esquadro was installed in other directory.
#
#######################################################################################

# To run this, is necessary one argument, 
# WORK_DIR(Where esquadro is installed)

if [ ! -n "$1" ]
then
    echo "Oops! Please insert where esquadro is installed..."
    exit
fi

WORK_DIR="$1"

# Remove last slashes
WORK_DIR=${1%/}



# The follow lines set inside runTransformation.sh where is job.kjb and kitchen.sh .
# To more info about syntax line, execute: man see, in terminal. About files and directories
# see runTransformations.sh

CURRENT_SCRIPT="$WORK_DIR/transformations/runTransformation.sh"

sed -i "/JOB_FILE=\"/usr/esquadro/transformations/job.kjb\"/c\JOB_FILE=\$WORK_DIR/transformations/job.kjb\"" "$WORK_DIR/transformations/runTransformation.sh"

#sed -i "/KITCHEN_DIR=\"$DEFAULT_DIR/data-integration/kitchen.sh\"/c\KITCHEN_DIR=\"$WORK_DIR/data-integration/kitchen.sh\"" $CURRENT_SCRIPT

# END
