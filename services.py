import os

# Get root directory
ROOT = os.environ['HOME']

# Run analizo from HOME path
def run_analizo(path, METRICS_CSV):
	# Generate all metrics values
	print("Getting metrics from " + ROOT + path)
	absolute_path = ROOT + path.replace('\n', '')
	print(absolute_path+METRICS_CSV)
	print("Run " + "analizo metrics -o " + absolute_path + METRICS_CSV + " " + absolute_path)
	os.system("analizo metrics -o " + absolute_path + METRICS_CSV + " " + absolute_path)
