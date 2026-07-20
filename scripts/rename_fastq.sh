#!/bin/bash

# Rename all compressed FASTQ files by replacing
# spaces in their filenames with underscores.

# Loop through every file ending in .fastq.gz
for f in *.fastq.gz
do
    # Rename the file.
    #
    # "$f"        = the current filename
    # ${f// /_}   = replace every space with an underscore

    mv "$f" "${f// /_}"
done

