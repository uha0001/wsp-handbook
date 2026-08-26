# SLURM Basics

SLURM is a workload manager used to organize computational jobs and distribute
computing resources between users.

As part of the planned WSP update, SLURM will be introduced to improve resource
sharing and prevent individual analyses from occupying an excessive proportion
of WSP's computing resources.

Instead of running computationally intensive analyses directly in the terminal,
users will submit jobs to SLURM.

SLURM then determines when the job can run based on the resources requested and
the resources currently available.

> **Note**
>
> SLURM is currently being introduced on WSP.
> WSP-specific limits and configuration details will be added after the
> installation and testing are complete.

---

## Why use SLURM?

WSP is a shared computational resource.

Without a workload manager, several users may start large analyses at the same
time or a single analysis may consume most of the available CPUs or memory.

SLURM helps to:

- distribute computing resources between users
- prevent one job or project from monopolizing WSP
- queue jobs when sufficient resources are not currently available
- specify CPU and memory requirements
- define maximum job durations
- monitor running and waiting jobs
- keep a record of submitted jobs
- improve reproducibility by storing computational commands in job scripts

---

## Basic workflow

A typical SLURM workflow consists of:

1. Create a job script.
2. Specify the resources required by the analysis.
3. Add the commands needed to run the analysis.
4. Submit the script using `sbatch`.
5. Monitor the job using `squeue`.
6. Inspect the output and error files after the job finishes.

---

# Your first SLURM job

Create a file called:

```text
hello.sh
```

Add the following:

```bash
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
```

Submit the job:

```bash
sbatch hello.sh
```

SLURM will return a job ID:

```text
Submitted batch job 12345
```

The job ID can be used to monitor, inspect, or cancel the job.

---

# Basic SLURM commands

## View available resources

```bash
sinfo
```

This displays information about the available SLURM partitions and computing
resources.

The exact WSP configuration will be documented after SLURM is installed.

---

## View jobs

Show all jobs:

```bash
squeue
```

Show only your jobs:

```bash
squeue -u $USER
```

---

## Submit a job

```bash
sbatch job.sh
```

---

## Cancel a job

```bash
scancel JOB_ID
```

For example:

```bash
scancel 12345
```

---

# Requesting resources

Resources are requested using `#SBATCH` directives near the beginning of the
job script.

For example:

```bash
#SBATCH --cpus-per-task=8
#SBATCH --mem=16G
#SBATCH --time=04:00:00
```

This requests:

- 8 CPU cores
- 16 GB of memory
- a maximum runtime of 4 hours

---

## Requesting CPUs

Example:

```bash
#SBATCH --cpus-per-task=8
```

Only request CPUs that the program can actually use.

For example, if a program supports eight threads, the program itself should
normally also be instructed to use eight threads.

A hypothetical example:

```bash
PROGRAM --threads 8
```

Requesting more CPUs does not automatically make an analysis faster.

Unused CPUs remain unavailable to other jobs while they are allocated to your
job.

---

## Requesting memory

Example:

```bash
#SBATCH --mem=16G
```

This requests 16 GB of RAM for the job.

Memory requirements depend on:

- the software
- dataset size
- reference genome size
- number of samples
- analysis type

Avoid requesting substantially more memory than necessary because allocated
memory may not be available to other users.

---

## Setting a time limit

One hour:

```bash
#SBATCH --time=01:00:00
```

Twelve hours:

```bash
#SBATCH --time=12:00:00
```

Two days:

```bash
#SBATCH --time=2-00:00:00
```

The general format is:

```text
days-hours:minutes:seconds
```

Jobs that exceed their requested wall time may be terminated by SLURM.

---

# Job names

Give jobs meaningful names:

```bash
#SBATCH --job-name=fastqc_sample01
```

Meaningful names make jobs easier to identify when using:

```bash
squeue
```

Avoid names such as:

```text
test
job
analysis
newjob
```

when running multiple analyses.

---

# Output and error files

SLURM can save standard output and error messages to files.

Recommended:

```bash
#SBATCH --output=%x_%j.out
#SBATCH --error=%x_%j.err
```

where:

- `%x` = job name
- `%j` = job ID

For a job called `fastqc` with job ID `12345`, this creates:

```text
fastqc_12345.out
fastqc_12345.err
```

Keep these files when troubleshooting failed analyses.

---

# Running software environments

If software is installed inside a Conda environment, the environment may need
to be activated inside the SLURM script.

For example:

```bash
source ~/miniconda3/etc/profile.d/conda.sh
conda activate my_environment

PROGRAM
```

The exact path depends on the user's Conda installation.

See:

[Conda and Environments](05_conda_and_environments.md)

---

# Interactive work

Small commands, file inspection, editing scripts, and other lightweight tasks
may be performed interactively.

Computationally intensive analyses should be submitted through SLURM.

Interactive SLURM procedures for WSP will be documented after the scheduler
configuration is finalized.

---

# WSP resource limits

The following will be added after SLURM configuration and testing:

- maximum CPUs per job
- maximum memory per job
- maximum wall time
- maximum simultaneous resource allocation
- fair-share rules
- queue/partition configuration
- procedures for exceptionally large jobs
- interactive-job rules

See:

[WSP Usage Policy](12_wsp_usage_policy.md)
