## It's an parser of csv to json
##
## Analizo generate an csv with pattern:
##	---
##	filename:
##		- directory/file.java
##	_module: boo::foo:file
## 	metric: value
##	...
##	---
##	...
##
## Pentaho DI use an JSON file with pattern:
##	[
##		{
##		"filename": "directory/file.java",
##		"module": "boo:foo:file",
##		"metric": "value"
##		...
##		},
##		...
##	]			
##

import os

METRICS_DIR = "metrics/"

# Get path of file cfg
PATH = os.environ['HOME'] + '/esquadro.list'

def get_metrics(token):
	open(METRICS_DIR + token[0] + '.json', 'a')
	output = open(METRICS_DIR + token[0] + '.json', 'w')
	output.write("Something")
	output.close()

esquadro_list = open(PATH)
for project in esquadro_list:
	# Generate to strings. First is name, second project url
	token = project.split('=')
	get_metrics(token)

