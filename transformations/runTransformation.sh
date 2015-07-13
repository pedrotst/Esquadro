#!/bin/bash
#json="/home/pwener/Documentos/scripts/transformations/tests/104.json"
json="$1"
if [ -e $json ]; then
	echo "Archive json found!"
else
	echo "Script fail because it can not find json file"
	exit 0
fi

path_json_file=$(cd $(dirname "$json") && pwd -P)/$(basename "$json")

#log="../log.file"
log="$2"
if [ -e $log ]; then
	echo "Log file exist!"
else
	touch "$log"
	echo "Created..."
fi

path_log_file=$(cd $(dirname "$log") && pwd -P)/$(basename "$log")


pentahoDirectory="$HOME/App/data-integration/kitchen.sh"
job="job.kjb"
json="/home/pwener/Documentos/scripts/transformations/tests/104.json"
command="$pentahoDirectory -file=\"$job\" -level=RowLevel -param:JSON_FILE=\"$path_json_file\" -logfile=\"$path_log_file\""
echo "$command"
eval "$command"
