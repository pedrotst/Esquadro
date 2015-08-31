#!/bin/bash

# Get an relative path of an log file
json="$1"

# Verify if archive exist
if [ ! -e $json ]; then
	echo "Script fail because it can not find json file"
	exit 0
fi

# Get absolut path of json file which 
# has metrics about certain project
path_json_file=$(cd $(dirname "$json") && pwd -P)/$(basename "$json")

# Get an relative path of an log file
log="$2"

# Verify if log file of kitchen exist
if [ ! -e $log ]; then
	touch "$log"
	echo "Created..."
fi

# Get absolut path of $log file which has metrics about
# about certain project
path_log_file=$(cd $(dirname "$log") && pwd -P)/$(basename "$log")

# Alterar para usar os diretorios onde for instalado o di
pentahoDirectory="usr/esquadro/data-integration/kitchen.sh"

#job="job.kjb"
command="$pentahoDirectory -file=\"$job\" -level=RowLevel -param:JSON_FILE=\"$path_json_file\" -logfile=\"$path_log_file\""

echo "$command"
eval "$command"
