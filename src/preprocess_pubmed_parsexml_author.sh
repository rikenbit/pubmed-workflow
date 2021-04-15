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

tmpfile=$(mktemp)
python src/preprocess_pubmed_parsexml_author.py $1 $tmpfile
python src/assigncoordinate.py -s airport $tmpfile $2