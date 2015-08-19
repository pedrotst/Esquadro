## It's an parser of csv to json
##
## Analizo generate an csv with pattern:
##	---
##	filename:
##		- directory/file.java
##	_module: boo::foo:file
## 	metric_name: value
##	...
##	---
##	...
##
## Pentaho DI use an JSON file with pattern:
##	[
##		{
##		"filename": "directory/file.java",
##		"module": "boo:foo:file",
##		"metric_name": "value"
##		...
##		},
##		...
##	]			
##

import os
import csv
import json
import sys

METRICS_DIR = "metrics/"
PROJECT_INFO_FILE = ".esquadro"
METRICS_CSV = "metrics.csv"

# Get root directory
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
		sys.exit()

	# An dictionarie to get informations
	contents = {}
	
	for line in info_file:
		token = line.split('=')
		contents[token[0]] = token[1].replace('\n', '')
	
	info_file.close()

	return contents


# Converts an csv file of metrics to json
def metrics_json(path_project):
	try:
		metrics_per_file = []

		field_names = ('_filename', '_module')	

		with open(ROOT + path_project + METRICS_CSV, 'r') as csv_metrics:
			lines = csv_metrics.readlines()
			file_metrics = {}
			# Count how many separators have between 
			separator_count = 0
			
			for line_number in range(0, len(lines)):
				line = lines[line_number]
				
				if '---' in line:
					separator_count += 1
					if separator_count == 2:
						metrics_per_file.append(file_metrics.copy())
						file_metrics.clear()
						separator_count = 0

				elif field_names[0] in line:
					try:
						file_metrics[field_names[0]] = line[line_number + 1]
					except IndexError:
						break
				elif field_names[1] in line:
					file_metrics[field_names[1]] = line.replace('_module: ', '')
				else:
					metric = line.split(':')
					file_metrics[metric[0]] = float(metric[1].replace('\n', ''))
					
			csv_metrics.close()

		return metrics_per_file

	except FileNotFoundError:
		print("File metrics.csv not found!")
		sys.exit()	


# Get metrics from token
def get_metrics(token):	
	output = open(METRICS_DIR + token[0] + '.json', 'w')

	path_project = token[1].replace('\n', '')

	# Get informations about project
	info_project = get_info(path_project)
	
	# Get metric in json
	metrics = metrics_json(path_project)
	print(len(metrics))

	# Format to json and write in output
	info_in_json = json.dumps(info_project)

	output.write(info_in_json)
	
	output.close()


if __name__=="__main__":
	try:
		esquadro_list = open(PATH_LIST)
	except FileNotFoundError:
		print("File esquadro.list needs to be created!" 
			+ "To more information see #link")
		sys.exit()
		
	for project in esquadro_list:
		# Generate to strings. First is name, second project url
		token = project.split('=')
		get_metrics(token)
		print("Metrics was collected from " + token[0])
