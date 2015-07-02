#!/bin/bash
log="/home/pedro/log.file"
pentahoDirectory="/opt/pentaho/data-integration/kitchen.sh"
job="job.kjb"
json="../../Downloads/105.json"
command="$pentahoDirectory -file=\"$job\" -level=RowLevel -param:JSON_FILE=\"$json\" -logfile=\"$log\""
echo "$command"
eval "$command"
