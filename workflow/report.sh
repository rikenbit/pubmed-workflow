# HTML
mkdir -p report
mkdir -p report/v002
snakemake -s workflow/download.smk --report report/v002/download.html
snakemake -s workflow/preprocess.smk --report report/v002/preprocess.html
snakemake -s workflow/metadata.smk --report report/v002/metadata.html
snakemake -s workflow/plot.smk --report report/v002/plot.html
