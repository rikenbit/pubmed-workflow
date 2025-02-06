# HTML
mkdir -p report
mkdir -p report/v009
snakemake -s workflow/download.smk --report report/v009/download.html
snakemake -s workflow/preprocess.smk --report report/v009/preprocess.html
snakemake -s workflow/metadata.smk --report report/v009/metadata.html
snakemake -s workflow/plot.smk --report report/v009/plot.html
