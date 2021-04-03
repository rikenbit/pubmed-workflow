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

# CSV Output
today=`date +%d-%b-%Y`
cat src/metadata_template.csv | sed -e "s|XXXXX|$2|g" | sed -e "s|YYYYY|$today|g" | sed -e "s|ZZZZZ|$1|g" > $3