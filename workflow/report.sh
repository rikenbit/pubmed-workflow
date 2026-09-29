# HTML
mkdir -p report
mkdir -p report/v012
snakemake -s workflow/download.smk --report report/v012/download.html
snakemake -s workflow/preprocess.smk --report report/v012/preprocess.html
snakemake -s workflow/metadata.smk --report report/v012/metadata.html
snakemake -s workflow/plot.smk --report report/v012/plot.html
