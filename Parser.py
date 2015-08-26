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
BLOCK_SEPARATOR = '---'
NAME_OF_CLASS_INDICATOR = '  - '

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

# Append dictonary of metrics in an list of all metrics
def save_metrics(project_metrics, metrics):
	project_metrics.append(metrics.copy())
	metrics.clear()

# For each line they will treat
def treat_any_line(file_metrics, file_lines, property_by_file):
	# It is an type of information inside of csv
	field_names = ('_filename', '_module')

	# Too see if an block was initiate
	# Block is mark by: --- in an csv of analizo
	block_open = False

	for line_number in range(0, len(file_lines)):
		line = file_lines[line_number]
		
		if BLOCK_SEPARATOR in line:
			if block_open:
				save_metrics(property_by_file, file_metrics)
			else:
				block_open = True
			pass
		
		# Yet read!
		elif NAME_OF_CLASS_INDICATOR in line:
			pass

		# It is an type of information inside of csv
		elif field_names[0] in line:
			# Remove /n
			name_of_class = file_lines[line_number + 1].replace('\n', '')
			# Remove indicator
			name_of_class = name_of_class.replace(NAME_OF_CLASS_INDICATOR, '')

			file_metrics[field_names[0]] = name_of_class

		# It is an type of information inside of csv
		elif field_names[1] in line:
			line = line.replace('_module: ', '').replace('\n', '')
			file_metrics[field_names[1]] = line

		# Metrics only have name and value, separated by ':'
		else:
			metric = line.split(':')
			file_metrics[metric[0]] = float(metric[1].replace('\n', ''))
			try:
				file_lines[line_number + 1]
			except IndexError:
				property_by_file.append(file_metrics.copy())
				file_metrics.clear()


# Converts an csv file of metrics to json
def metrics_json(path_project):
	try:
		# Have name of file, package and all metrics about
		property_by_file = []

		with open(ROOT + path_project + METRICS_CSV, 'r') as csv_metrics:
			file_lines = csv_metrics.readlines()
			file_metrics = {}

			treat_any_line(file_metrics, file_lines, property_by_file)

			csv_metrics.close()

		return property_by_file

	except FileNotFoundError:
		print("File metrics.csv not found!")
		sys.exit()	


# Get metrics from token
def get_metrics(token):	
	output = open(METRICS_DIR + token[0] + '.json', 'w')

	path_project = token[1].replace('\n', '')

	# Get informations about project
	info_project = get_info(path_project)
	
	# Format to json and write in output
	info_in_json = json.dumps(info_project)

	# Write informations opening json declaration with
	# '[' and adding ',' after this block
	output.write('[' + info_in_json + ',')

	metrics = metrics_json(path_project)

	# Get all metrics and convert to json
	for metrics_by_file in metrics:
		metrics_by_file_json = json.dumps(metrics_by_file)
		output.write(metrics_by_file_json)

		if(metrics_by_file is not metrics[-1]):
			output.write(',')

	# Close json
	output.write(']')

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
