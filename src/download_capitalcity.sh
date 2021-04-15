#!/bin/bash
#$ -l nc=4
#$ -p -50
#$ -r yes
#$ -q node.q

#SBATCH -n 4
#SBATCH --nice=50
#SBATCH --requeue
#SBATCH -p node03-06
SLURM_RESTART_COUNT=2

export LC_ALL=C

wget https://www.dropbox.com/s/pksim0ampbhmj1d/h2706world_utf8.csv?dl=0
mv h2706world_utf8.csv?dl=0 data/h2706world_utf8.csv
