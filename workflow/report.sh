# HTML
mkdir -p report
mkdir -p report/v010
snakemake -s workflow/download.smk --report report/v010/download.html
snakemake -s workflow/preprocess.smk --report report/v010/preprocess.html
snakemake -s workflow/metadata.smk --report report/v010/metadata.html
snakemake -s workflow/plot.smk --report report/v010/plot.html
