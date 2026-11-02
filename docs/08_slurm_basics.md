# SLURM Basics

SLURM is a workload manager that organizes computational jobs and distributes computing resources among users.

**SLURM is now installed and operational on WSP.**

WSP is a shared workstation used by multiple researchers. SLURM helps ensure fair distribution of computational resources and prevents large analyses from interfering with other users' work.

Instead of running computationally intensive analyses directly in the terminal, users should submit their jobs through SLURM.

SLURM determines when jobs can run based on the requested resources and current availability.

> **Important:** SLURM manages resources allocated to jobs submitted through SLURM. It does not automatically restrict processes started directly from an SSH session or desktop terminal.

---

## Why use SLURM?

SLURM helps to:

- Distribute computing resources between users.
- Prevent individual jobs from monopolizing WSP.
- Queue jobs when resources are unavailable.
- Specify CPU, memory, and runtime requirements.
- Monitor running and pending jobs.
- Cancel jobs when necessary.
- Keep records of completed analyses.
- Improve reproducibility through job scripts.

## WSP configuration

WSP has one SLURM-managed computational node.

| Resource | Configuration |
|---|---|
| Partition | `main` |
| Logical CPUs | 112 |
| System memory | Approximately 499 GiB |
| Default job duration | 48 hours |
| Maximum job duration | 30 days |
| SLURM account | `lab` |
| Resource-limiting QOS | `wsp_limits` |

The following resource limits were configured for the `wsp_limits` QOS:

| Resource | Limit |
|---|---|
| Maximum CPUs per job | 48 |
| Maximum memory per job | 250 GB |
| Maximum CPUs per user | 64 |
| Maximum memory per user | 300 GB |
| Maximum running jobs per user | 10 |
| Maximum submitted jobs per user | 100 |
| Maximum wall time | 30 days |

These limits help prevent individual analyses from using too much of WSP.

Users can run multiple jobs simultaneously, as long as their combined resource requests stay within the applicable limits.

> **Note:** These values reflect the configured WSP limits and should be checked against the live SLURM configuration if administrator settings change.

---

# Your first SLURM job

A typical SLURM workflow consists of:

1. Create a job script.
2. Specify the required resources.
3. Load the necessary software.
4. Add the analysis commands.
5. Submit the job using `sbatch`.
6. Monitor the job using `squeue`.
7. Inspect the output after completion.

## Create a job script

Create a file named `hello.sh`:

```bash
nano hello.sh
```

Add the following:

```bash
#!/bin/bash

#SBATCH --job-name=hello
#SBATCH --partition=main
#SBATCH --cpus-per-task=1
#SBATCH --mem=1G
#SBATCH --time=00:05:00
#SBATCH --output=hello_%j.out
#SBATCH --error=hello_%j.err

hostname
date
echo "Hello from WSP"
```

Save the file.

## Submit the job

```bash
sbatch hello.sh
```

SLURM will return a job ID, for example:

```text
Submitted batch job 12345
```

The job ID can be used to monitor, inspect, or cancel the job.

## Check the output

After the job finishes:

```bash
cat hello_12345.out
```

Replace `12345` with the actual job ID.

The output should contain the workstation hostname, date, and the message:

```text
Hello from WSP
```

---

# Basic SLURM commands

## View available resources

```bash
sinfo
```

This displays information about SLURM partitions, node availability, and node states.

For more detailed information:

```bash
sinfo -N -l
```

## View jobs

Show all queued and running jobs:

```bash
squeue
```

Show only your jobs:

```bash
squeue -u $USER
```

## Submit a job

```bash
sbatch job.sh
```

## Cancel a job

```bash
scancel JOB_ID
```

For example:

```bash
scancel 12345
```

## Inspect a job

```bash
scontrol show job JOB_ID
```

This provides detailed information about the job, including requested resources, status, and execution details.

## View completed jobs

```bash
sacct -u $USER --starttime today
```

For a specific job:

```bash
sacct -j JOB_ID --format=JobID,JobName,State,Elapsed,ExitCode,MaxRSS
```

`MaxRSS` helps assess memory usage, but its availability and interpretation depend on the accounting data.

---

# Requesting resources

Resources are specified using `#SBATCH` directives near the beginning of the job script.

For example:

```bash
#SBATCH --partition=main
#SBATCH --cpus-per-task=8
#SBATCH --mem=16G
#SBATCH --time=04:00:00
```

This requests:

- 8 CPUs.
- 16 GB of memory.
- A maximum runtime of 4 hours.

SLURM reserves these resources when the job starts.

## Requesting CPUs

```bash
#SBATCH --cpus-per-task=8
```

Request only the CPUs the program can actually use.

For example, if a program supports eight threads, configure it to use the allocated CPUs:

```bash
PROGRAM --threads 8
```

For programs supporting a thread argument, SLURM provides the allocated CPU count through:

```bash
$SLURM_CPUS_PER_TASK
```

For example:

```bash
PROGRAM --threads "$SLURM_CPUS_PER_TASK"
```

This avoids manually changing the thread count whenever the job's CPU allocation changes.

**Requesting more CPUs does not automatically make an analysis faster.**

Unused allocated CPUs are unavailable to other SLURM jobs.

## Requesting memory

```bash
#SBATCH --mem=16G
```

This requests 16 GB of memory for the job.

Memory requirements depend on the software, dataset size, reference genome, number of samples, and analysis type.

Avoid requesting substantially more memory than necessary.

Jobs that exceed their enforced memory allocation may be terminated.

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

Jobs exceeding their wall-time limit may be terminated by SLURM.

On WSP, the configured maximum is 30 days.

---

# Job names and output files

Give jobs meaningful names:

```bash
#SBATCH --job-name=fastqc_sample01
```

Meaningful names make analyses easier to identify.

Avoid generic names such as `test`, `job`, or `analysis` when running multiple jobs.

## Output and error files

Recommended:

```bash
#SBATCH --output=%x_%j.out
#SBATCH --error=%x_%j.err
```

Where:

- `%x` is the job name.
- `%j` is the job ID.

For a job named `fastqc` with job ID `12345`, this creates:

```text
fastqc_12345.out
fastqc_12345.err
```

Keep these files when troubleshooting failed analyses.

---

# Running software with Lmod

WSP uses **Lmod** to manage scientific software environments.

Lmod allows users to select installed software versions without manually modifying system paths.

Several programs are available through version-specific modules, including Samtools, BCFtools, R, GATK, Singularity, and Snakemake.

## View available modules

```bash
module avail
```

## Load a module

For example:

```bash
module load samtools/1.25
```

Check the selected version:

```bash
samtools --version
```

## Load multiple modules

```bash
module load samtools/1.25 bcftools/1.25
```

Some modules may be incompatible if they require conflicting software environments.

## View loaded modules

```bash
module list
```

## Unload a module

```bash
module unload samtools/1.25
```

## Switch software versions

For example:

```bash
module swap samtools/1.25 samtools/1.11
```

## Using modules inside SLURM scripts

Load software modules explicitly inside job scripts to make analyses more reproducible.

Example:

```bash
#!/bin/bash

#SBATCH --job-name=samtools_example
#SBATCH --partition=main
#SBATCH --cpus-per-task=4
#SBATCH --mem=8G
#SBATCH --time=01:00:00
#SBATCH --output=%x_%j.out
#SBATCH --error=%x_%j.err

source /etc/profile.d/lmod.sh

module load samtools/1.25

samtools --version
```

The `source` command initializes Lmod if it is not already available in the batch shell.

This approach avoids relying on software versions loaded during an earlier interactive session.

## Selected WSP software modules

The following modules have been configured during the WSP setup:

| Software | Version |
|---|---|
| Samtools | 1.11, 1.25 |
| BCFtools | 1.11, 1.25 |
| HTSlib | 1.25 |
| VCFtools | 0.1.13, 0.1.18 |
| R | 4.5.2, 4.6.2 |
| BWA | 0.7.19 |
| BWA-MEM2 | 2.1 |
| GATK | 4.2.2.0, 4.7.0.0 |
| Singularity CE | 4.6.0 |
| Snakemake | 9.27.1 |

The availability of additional software should be checked using `module avail`.

> **Note:** A working module and version command confirm that the executable can be found, but they do not necessarily verify every feature or dependency of the software.

---

# Running Conda environments

Users may also run software installed inside Conda environments.

For example:

```bash
#!/bin/bash

#SBATCH --job-name=conda_example
#SBATCH --partition=main
#SBATCH --cpus-per-task=4
#SBATCH --mem=8G
#SBATCH --time=02:00:00

source ~/miniconda3/etc/profile.d/conda.sh

conda activate my_environment

PROGRAM
```

The initialization path depends on the user's Conda installation.

Where suitable, use existing WSP software modules instead of installing duplicate software environments.

See [Conda and Environments](https://github.com/uha0001/wsp-handbook/blob/main/docs/05_conda_and_environments).

---

# Interactive SLURM jobs

Some analyses require an interactive environment, for example when testing software, debugging scripts, or examining intermediate results.

An interactive allocation can be requested using:

```bash
srun --partition=main --cpus-per-task=2 --mem=4G --time=01:00:00 --pty bash
```

This requests two CPUs, 4 GB of memory, and one hour of runtime.

When resources become available, SLURM starts an interactive shell within the allocation.

Run the necessary commands and exit when finished:

```bash
exit
```

The allocated resources are then released.

For ordinary file inspection, script editing, and lightweight commands, a SLURM allocation is generally unnecessary.

---

# Monitoring resource usage

SLURM provides tools to monitor jobs and understand resource requirements.

## Monitor running jobs

```bash
squeue -u $USER
```

Common job states include:

| State | Meaning |
|---|---|
| `PD` | Pending |
| `R` | Running |
| `CG` | Completing |
| `CD` | Completed |
| `F` | Failed |
| `CA` | Cancelled |
| `TO` | Timed out |
| `OOM` | Out of memory |

Some states appear primarily in accounting output rather than the active queue.

## Check why a job is pending

```bash
squeue -j JOB_ID -o "%.18i %.9T %.30R"
```

The final column may show a reason such as insufficient resources or a scheduling limit.

## Check job efficiency

After completion:

```bash
sacct -j JOB_ID --format=JobID,JobName,Elapsed,AllocCPUS,MaxRSS,State
```

Reviewing resource usage helps improve future CPU and memory requests.

---

# Troubleshooting

## My job is pending

Possible reasons include:

- Insufficient available CPUs.
- Insufficient available memory.
- Another job is using the required resources.
- The job exceeds a configured resource limit.
- The maximum number of running jobs has been reached.

Check:

```bash
squeue -j JOB_ID -o "%.18i %.9T %.30R"
```

## My job failed

Inspect the error file:

```bash
cat JOB_NAME_JOB_ID.err
```

Also inspect the job state:

```bash
sacct -j JOB_ID --format=JobID,State,ExitCode,Elapsed
```

## My job ran out of memory

If SLURM reports an out-of-memory condition, the analysis may require more RAM.

Check the recorded memory usage and adjust the requested allocation if necessary.

Do not automatically request the maximum available memory.

## My program cannot be found

Check the loaded modules:

```bash
module list
```

Search available modules:

```bash
module avail
```

Load the required software version inside the job script.

## My job was terminated unexpectedly

Possible causes include:

- Exceeding the requested runtime.
- Exceeding the memory allocation.
- Software errors.
- Missing input files.
- Incorrect paths or permissions.

Inspect both the SLURM accounting information and the job's output and error files.

---

# WSP usage recommendations

To keep WSP available for everyone:

- Submit computationally intensive analyses through SLURM.
- Request realistic CPU, memory, and runtime allocations.
- Use software modules where available.
- Avoid running large analyses directly in SSH or desktop sessions.
- Cancel jobs that are no longer needed.
- Monitor jobs and investigate failures.
- Keep job scripts and relevant logs for reproducibility.
- Avoid submitting large numbers of unnecessary jobs.
- Coordinate exceptionally resource-intensive analyses with the workstation administrators.

SLURM improves resource sharing, but responsible usage remains important.

For additional information, see [WSP Usage Policy](12_wsp_usage_policy.md).
