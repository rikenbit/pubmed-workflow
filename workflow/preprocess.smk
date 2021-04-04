import pandas as pd
import glob
from snakemake.utils import min_version

min_version("6.0.5")

TYPES = ['pubmed', 'pmc', 'descriptor', 'qualifier', 'scr']
MEDLINES, = glob_wildcards('data/pubmed/zip/zip/{m}.xml')

rule all:
	input:
		expand('tibble/{t}_tbl.RData', t=TYPES),
		expand('datatable/{t}_dt.RData', t=TYPES)

#############################################
# Preprocess
#############################################

rule preprocess_pubmed_parsexml:
	input:
		'data/pubmed/zip/zip/{m}.xml'
	output:
		expand('data/pubmed/{t}_{{m}}.txt', t=TYPES, m=MEDLINES)
	container:
		'docker://logiqx/python-lxml:3.8-slim-buster'
	benchmark:
		'benchmarks/preprocess_pubmed_parsexml_{m}.txt'
	log:
		'logs/preprocess_pubmed_parsexml_{m}.log'
	shell:
		'src/preprocess_pubmed_parsexml.sh {input} >& {log}'

rule preprocess_merge_sort_unique:
	input:
		expand('data/pubmed/{{t}}_{m}.txt', t=TYPES, m=MEDLINES)
	output:
		'data/pubmed/{t}.txt'
	container:
		'docker://logiqx/python-lxml:3.8-slim-buster'
	benchmark:
		'benchmarks/preprocess_merge_sort_unique_{t}.txt'
	log:
		'logs/preprocess_merge_sort_unique_{t}.txt'
	shell:
		'(cat {input} | sort | uniq > {output}) >& {log}'

rule preprocess_sqlite:
	input:
		'data/pubmed/{t}.txt'
	output:
		'sqlite/{t}.sqlite'
	container:
		'docker://logiqx/python-lxml:3.8-slim-buster'
	benchmark:
		'benchmarks/preprocess_sqlite_{t}.txt'
	log:
		'logs/preprocess_sqlite_{t}.txt'
	shell:
		'src/preprocess_sqlite_{wildcards.t}.sh {input} {output} >& {log}'

rule preprocess_tibble:
	input:
		'sqlite/{t}.sqlite'
	output:
		'tibble/{t}_tbl.RData'
	container:
		'docker://rocker/tidyverse:4.0.4'
	benchmark:
		'benchmarks/preprocess_tibble_{t}.txt'
	log:
		'logs/preprocess_tibble_{t}.txt'
	shell:
		'src/preprocess_tibble_{wildcards.t}.sh {input} {output} >& {log}'


rule preprocess_datatable:
	input:
		'sqlite/{t}.sqlite'
	output:
		'datatable/{t}_dt.RData'
	container:
		'docker://rocker/tidyverse:4.0.4'
	benchmark:
		'benchmarks/preprocess_datatable_{t}.txt'
	log:
		'logs/preprocess_datatable_{t}.txt'
	shell:
		'src/preprocess_datatable_{wildcards.t}.sh {input} {output} >& {log}'
