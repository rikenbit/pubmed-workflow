# HTML
mkdir -p report
mkdir -p report/v001
snakemake -s workflow/download.smk --report report/v001/download.html
snakemake -s workflow/preprocess.smk --report report/v001/preprocess.html
snakemake -s workflow/metadata.smk --report report/v001/metadata.html
snakemake -s workflow/plot.smk --report report/v001/plot.html