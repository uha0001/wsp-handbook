#!/bin/bash

# Display the size of every file and directory
# in the current working directory.

# du = disk usage
# -s = show only the total size for each item
# -h = display sizes in a human-readable format (KB, MB, GB)

# * means "all files and directories" in the current directory.

du -sh *
