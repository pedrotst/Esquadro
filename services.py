## This module have methods that works with external applications

import os

# Get root directory
ROOT = os.environ['HOME']

# Run analizo from HOME path
def run_analizo(path, METRICS_CSV):
	# Generate all metrics values
	absolute_path = ROOT + path.replace('\n', '')

	print("Getting metrics from " + absolute_path)
	
	os.system("analizo metrics -o " + absolute_path + METRICS_CSV + " " + absolute_path)
