import pandas as pd
import glob
from snakemake.utils import min_version

min_version("6.0.5")

rule all:
	input:
		'check/download_pubmed'

#############################################
# Download
#############################################

rule download_pubmed:
	output:
		'check/download_pubmed'
	benchmark:
		'benchmarks/download_pubmed.txt'
	container:
		'docker://koki/lwp_pl:latest'
	log:
		'logs/download_pubmed.log'
	shell:
		'src/download_pubmed.sh >& {log}'
