# HTML
mkdir -p report
mkdir -p report/v004
snakemake -s workflow/download.smk --report report/v004/download.html
snakemake -s workflow/preprocess.smk --report report/v004/preprocess.html
snakemake -s workflow/metadata.smk --report report/v004/metadata.html
snakemake -s workflow/plot.smk --report report/v004/plot.html
