import pandas as pd
import glob
from snakemake.utils import min_version

min_version("6.0.5")

rule all:
	input:
		'check/download_pubmed',
		'data/GlobalAirportDatabase/GlobalAirportDatabase.txt',
		'data/GlobalAirportDatabase/readme.txt',
		'data/h2706world_utf8.csv'

#############################################
# Download
#############################################

rule download_pubmed:
	output:
		'check/download_pubmed'
	container:
		'docker://koki/lwp_pl:latest'
	benchmark:
		'benchmarks/download_pubmed.txt'
	log:
		'logs/download_pubmed.log'
	shell:
		'src/download_pubmed.sh >& {log}'

rule download_globalairportdatabase:
	output:
		'data/GlobalAirportDatabase/GlobalAirportDatabase.txt',
		'data/GlobalAirportDatabase/readme.txt'
	container:
		'docker://koki/lwp_pl:latest'
	benchmark:
		'benchmarks/download_globalairportdatabase.txt'
	log:
		'logs/download_globalairportdatabase.log'
	shell:
		'src/download_globalairportdatabase.sh >& {log}'

rule download_capitalcity:
	output:
		'data/h2706world_utf8.csv'
	container:
		'docker://koki/lwp_pl:latest'
	benchmark:
		'benchmarks/download_capitalcity.txt'
	log:
		'logs/download_capitalcity.log'
	shell:
		'src/download_capitalcity.sh >& {log}'