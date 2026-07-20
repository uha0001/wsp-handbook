#!/bin/bash

# Create a directory to store FastQC reports.

mkdir qc

# Run FastQC on all compressed FASTQ files
# in the current directory.
#
# *.fastq.gz = all FASTQ files ending in .fastq.gz
# -o qc      = save the FastQC reports in the "qc" directory

fastqc *.fastq.gz -o qc
