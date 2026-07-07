#!/bin/bash

mkdir qc

fastqc *.fastq.gz -o qc
