#!/bin/bash
#SBATCH --job-name=name
#SBATCH --output=%x_%j.out
#SBATCH --error=%x_%j.err
#SBATCH --time=04:00:00
#SBATCH --cpus-per-task=8
#SBATCH --mem=32G
#SBATCH --partition=normal
#SBATCH --array=0-9%5

# this is a job that you estimate to take 4 hours max with specified resources, 10 tasks will run, 5 tasks can run simultaniously.
# here you need a bash script of what you want to do, here is an exsample of a loop:

GENES=(name1 name2 name3)
GENE=${GENES[$SLURM_ARRAY_TASK_ID]}

grep ${GENE} file.txt > ${GENE}.out.txt
