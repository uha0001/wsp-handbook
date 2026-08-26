# SLURM Basics

SLURM is the workload manager used on WSP to organize computational jobs and
share computing resources between users.

Instead of running computationally intensive analyses directly from the
terminal, users submit jobs to SLURM.

SLURM determines when a job can run based on the resources requested and the
resources currently available.

> **Note:** SLURM is being introduced as part of the WSP update. WSP-specific
> resource limits will be added after the configuration has been finalized.

---

## Why do we use SLURM?

WSP is a shared computational resource.

SLURM helps:

- distribute CPUs and memory between users
- prevent one job or user from occupying the entire server
- queue jobs when resources are unavailable
- set maximum job durations
- track running and waiting jobs
- allocate resources according to actual requirements

---

# Basic SLURM workflow

A typical workflow is:

1. Create a job script.
2. Specify the resources required.
3. Submit the job using `sbatch`.
4. Monitor the job using `squeue`.
5. Examine the output and error files after completion.

---

# Your first job

Create a file called:

```text
hello.sh

#!/bin/bash

#SBATCH --job-name=hello
#SBATCH --cpus-per-task=1
#SBATCH --mem=1G
#SBATCH --time=00:05:00
#SBATCH --output=hello_%j.out
#SBATCH --error=hello_%j.err

hostname
date
echo "Hello from WSP"

---

Submit it:

sbatch hello.sh

SLURM will return a job ID:

Submitted batch job 12345


# Checking your jobs

Show your jobs:

squeue -u $USER

Show all jobs:

squeue
Cancelling a job
scancel JOB_ID

For example:

scancel 12345
Requesting CPUs
#SBATCH --cpus-per-task=8

This requests eight CPU cores.

Only request CPUs that the program can actually use.

Requesting more CPUs does not automatically make an analysis faster.

Requesting memory
#SBATCH --mem=16G

This requests 16 GB of RAM.

Memory requirements depend on the program and dataset.

Setting a time limit

One hour:

#SBATCH --time=01:00:00

Twelve hours:

#SBATCH --time=12:00:00

Two days:

#SBATCH --time=2-00:00:00

Jobs that exceed their requested time may be terminated by SLURM.

Output and error files

Use:

#SBATCH --output=%x_%j.out
#SBATCH --error=%x_%j.err

where:

%x = job name
%j = job ID

Keep these files when troubleshooting failed analyses.

# WSP resource limits

The following limits will be documented after the WSP SLURM configuration is
finalized:

-maximum CPUs per job
-maximum memory per job
-maximum job duration
-maximum concurrent resource use
-fair-share policy
-procedure for exceptionally large jobs

