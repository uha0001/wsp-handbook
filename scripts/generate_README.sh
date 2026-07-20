#!/bin/bash

# Create a README.md file containing a basic
# project template.

# cat writes the text below into the file.
# <<EOF marks the beginning of the text.
# Everything until the closing EOF will be
# written to README.md.

cat <<EOF > README.md
# RNAseq Project

Date:

Samples:

Goal:

Pipeline:

Results:
EOF
