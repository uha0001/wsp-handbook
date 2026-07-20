#!/bin/bash

# Create a compressed archive of the "results" directory.
# The backup file will be named "results_backup.tar.gz".

# tar  : Create an archive.
# -c   : Create a new archive.
# -z   : Compress the archive using gzip.
# -f   : Specify the output filename.
# results_backup.tar.gz : Name of the backup archive.
# results/ : Folder to include in the backup.

tar -czf results_backup.tar.gz results/
