# pubmed-workflow

Workflow to construct to preprocess PubMed XML files and save tibble datasets.

# Pre-requisites
- Bash: GNU bash, version 4.2.46(1)-release (x86_64-redhat-linux-gnu)
- Snakemake: 6.0.5
- Singularity: 3.5.3

# Summary
XXXX

# How to reproduce this workflow
## 1. Configuration
- **config.yaml**: XXXXXXXX


## 2. Perform snakemake command
The workflow consists of seven snakemake workflows.

In local machine:
```bash
snakemake -s workflow/download.smk -j 4 --use-singularity
snakemake -s workflow/preprocess.smk -j 4 --use-singularity
snakemake -s workflow/metadata.smk -j 4 --use-singularity
```

In parallel environment (GridEngine):
```bash
snakemake -s workflow/download.smk -j 4 --cluster "qsub -l nc=4 -p -50 -r yes -q node.q" --latency-wait 600 --use-singularity
snakemake -s workflow/preprocess.smk -j 4 --cluster "qsub -l nc=4 -p -50 -r yes -q node.q" --latency-wait 600 --use-singularity
snakemake -s workflow/metadata.smk -j 4 --cluster "qsub -l nc=4 -p -50 -r yes -q node.q" --latency-wait 600 --use-singularity
```

In parallel environment (Slurm):
```bash
snakemake -s workflow/download.smk -j 4 --cluster "sbatch -n 4 --nice=50 --requeue -p node03-06" --latency-wait 600 --use-singularity
snakemake -s workflow/preprocess.smk -j 4 --cluster "sbatch -n 4 --nice=50 --requeue -p node03-06" --latency-wait 600 --use-singularity
snakemake -s workflow/metadata.smk -j 4 --cluster "sbatch -n 4 --nice=50 --requeue -p node03-06" --latency-wait 600 --use-singularity
```

# License
Copyright (c) 2021 Koki Tsuyuzaki and RIKEN Bioinformatics Research Unit Released under the [Artistic License 2.0](http://www.perlfoundation.org/artistic_license_2_0).

# Authors
- Koki Tsuyuzaki
- Manabu Ishii
- Itoshi Nikaido