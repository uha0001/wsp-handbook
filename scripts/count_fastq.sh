#!/bin/bash

# Count the number of compressed FASTQ files
# in the current directory.

echo "FASTQ files:"

# ls        = list files
# *.fastq.gz = all files ending with ".fastq.gz"
# |         = send the output of one command to another
# wc -l     = count the number of lines (one file per line)

ls *.fastq.gz | wc -l
