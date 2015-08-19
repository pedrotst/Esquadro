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

import os, json

METRICS_DIR = "metrics/"
PROJECT_INFO_FILE = ".esquadro"

ROOT = os.environ['HOME']

# Get path of file with all projects tracked
PATH_LIST = ROOT + '/esquadro.list'

# Get info into .esquadro file to setting json of any project
def get_info(path_project):
	try:
		info_file = open(ROOT + path_project + PROJECT_INFO_FILE, 'r')
	except FileNotFoundError:
		print("File .esquadro in " + path_project 
			+ " needs to be created. To more info"
			+ " see #link")

	# An dictionarie to get informations
	contents = {}
	
	for line in info_file:
		token = line.split('=')
		contents[token[0]] = token[1].replace('\n', '')
	
	info_file.close()

	return contents
	

# Get metrics from token
def get_metrics(token):
	
	output = open(METRICS_DIR + token[0] + '.json', 'w')
	# Get informations about project
	info_project = get_info(token[1].replace('\n', ''))
	
	# Format to json and write in output
	info_in_json = json.dumps(info_project)
	output.write(info_in_json)

	output.close()

try:
	esquadro_list = open(PATH_LIST)
except FileNotFoundError:
	print("File esquadro.list needs to be created!" 
		+ "To more information see #link")

for project in esquadro_list:
	# Generate to strings. First is name, second project url
	token = project.split('=')
	get_metrics(token)
	print("Metrics was collected from " + token[0])
