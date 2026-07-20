#!/bin/bash

# Create a MultiQC report from the FastQC results.
#
# MultiQC searches the "qc" directory for supported
# report files and combines them into a single summary.

multiqc qc
