#!/bin/bash

#################################################
#
# This scripts run pentaho data-integration, which
# get json metric files and persist in database
#
#################################################

# Relative path of an json file, archive that have metrics
# of an project in an right settings

JSON_FILE="$1"

# Verify if archive JSON exist.

if [ ! -e $JSON_FILE ]; then
	echo "Script fail because it can not find json file..."
	exit 0
fi

# Get absolut path of json file which have metrics about certain project
# with right properties defined in .esquadro.map

JSON_FILE_DIR=$(cd $(dirname "$JSON_FILE") && pwd -P)/$(basename "$JSON_FILE")



# Get an relative path of log file

LOG_FILE="$2"

# Verify if log file of kitchen exist

if [ ! -e $LOG_FILE ]; then
	touch "LOG_FILE"
	echo "Created..."
fi

# Get absolut path of LOG_FILE, that will be used by
# data-integration in your call, made below

LOG_FILE_DIR=$(cd $(dirname "$LOG_FILE") && pwd -P)/$(basename "$LOG_FILE")

# Concatenate string

LOG_FILE_DIR="$LOG_FILE_DIR $LOG_FILE"



# @@@@ IT CAN BE CHANGE TO RELATIVE PATH
# Directory of pentaho script that will run dataintegration.
#
# Second pentaho documentation: Kitchen is a program that can
# execute jobs designed by Spoon in XML or in a database repository.

# Default directory, see script that can change this:
# configureTransformations.sh
WORK_DIR=/usr/esquadro

KITCHEN_DIR=$WORK_DIR/data-integration/kitchen.sh

JOB_FILE=$WORK_DIR/transformations/job.kjb

COMMAND="$KITCHEN_DIR -file="$JOB_FILE" -level=RowLevel -param:JSON_FILE="$JSON_FILE_DIR" -logfile="$LOG_FILE_DIR""

echo "$COMMAND"

# Run command
eval "$COMMAND"

# END

exit 0
