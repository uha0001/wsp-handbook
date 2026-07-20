#!/bin/bash

# Create a standard project directory structure.
#
# Usage:
# ./create_project.sh project_name

# Store the first command-line argument in the variable PROJECT.
# For example:
# ./create_project.sh rnaseq_project
# PROJECT will contain "rnaseq_project".

PROJECT=$1

# Create the project directory and its subdirectories.
# -p creates parent directories if they don't already exist
# and does not produce an error if they already exist.

mkdir -p $PROJECT/{raw_data,trimmed,qc,alignment,counts,results,figures,logs,metadata,scripts}

# Create an empty README file for project notes.

touch $PROJECT/README.md

# Print a confirmation message.

echo "Created project: $PROJECT"
