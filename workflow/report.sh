# HTML
mkdir -p report
mkdir -p report/v008
snakemake -s workflow/download.smk --report report/v008/download.html
snakemake -s workflow/preprocess.smk --report report/v008/preprocess.html
snakemake -s workflow/metadata.smk --report report/v008/metadata.html
snakemake -s workflow/plot.smk --report report/v008/plot.html
