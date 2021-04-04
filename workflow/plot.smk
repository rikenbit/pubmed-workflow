import pandas as pd
from snakemake.utils import min_version

min_version("6.0.5")
configfile: "config.yaml"

TIBBLE, = glob_wildcards('tibble/{t}_tbl.RData')

rule all:
	input:
		'plot/summary.png'

#############################################
# Plot
#############################################

rule plot:
	input:
		expand('tibble/{t}_tbl.RData', t=TIBBLE)
	output:
		'plot/summary.png'
	# container:
	# 	"docker://koki/biocdev:latest"
	container:
		'docker://rocker/tidyverse:4.0.4'
	benchmark:
		'benchmarks/plot.txt'
	log:
		'logs/plot.log'
	shell:
		'src/plot.sh >& {log}'