#!/bin/bash

PROJECT=$1

mkdir -p $PROJECT/{raw_data,trimmed,qc,alignment,counts,results,figures,logs,metadata,scripts}

touch $PROJECT/README.md

echo "Created project: $PROJECT"
