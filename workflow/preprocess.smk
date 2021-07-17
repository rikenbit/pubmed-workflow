import glob
from snakemake.utils import min_version

min_version("6.0.5")

TYPES = ['pubmed', 'abstract', 'author', 'pmc', 'descriptor', 'qualifier', 'scr']
MEDLINES, = glob_wildcards('data/pubmed/baseline/{m}.xml')

rule all:
	input:
		expand('tibble/{typ}_tbl.RData',typ=TYPES),
		expand('datatable/{typ}_dt.RData', typ=TYPES)


#############################################
# Preprocess
#############################################

def createfilelist(wildcards):
    if '_' in wildcards.t:
        return wildcards.t
    return ['data/pubmed/'+wildcards.t+'_{fn}.txt'.format(fn=fn) for fn in MEDLINES]

rule preprocess_pubmed_parsexml:
	input:
                'data/pubmed/baseline/{m}.xml'
	output:
		"data/pubmed/{t}_{m}.txt"
	container:
		'docker://koki/assigncoordinate:20210413'
	benchmark:
		'benchmarks/preprocess_pubmed_parsexml_{t}_{m}.txt'
	log:
		'logs/preprocess_pubmed_parsexml_{t}_{m}.log'
	shell:
		'src/preprocess_pubmed_parsexml_{wildcards.t}.sh {input} {output} >& {log}'

rule preprocess_merge_sort_unique:
	input:
                createfilelist
	output:
		'data/pubmed/{t}.txt'
	container:
		'docker://logiqx/python-lxml:3.8-slim-buster'
	benchmark:
		'benchmarks/preprocess_merge_sort_unique_{t}.txt'
	log:
		'logs/preprocess_merge_sort_unique_{t}.txt'
	shell:
		'(ls data/pubmed/{wildcards.t}_*.txt | xargs cat | sort | uniq > {output}) >& {log}'
		#'(cat {input} | sort | uniq > {output}) >& {log}'

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
