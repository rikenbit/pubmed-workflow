# HTML
mkdir -p report
mkdir -p report/v011
snakemake -s workflow/download.smk --report report/v011/download.html
snakemake -s workflow/preprocess.smk --report report/v011/preprocess.html
snakemake -s workflow/metadata.smk --report report/v011/metadata.html
snakemake -s workflow/plot.smk --report report/v011/plot.html
