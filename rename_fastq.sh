#!/bin/bash

for f in *.fastq.gz
do
    mv "$f" "${f// /_}"
done
