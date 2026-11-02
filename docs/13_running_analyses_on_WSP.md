# Running Analyses on WSP

WSP is a shared computational workstation used for bioinformatics and other data-intensive research.

Computationally intensive analyses should be submitted through **SLURM**, which manages CPU, memory, and runtime allocations.

This guide provides practical examples of running scientific software on WSP using SLURM and Lmod environment modules.

For an introduction to SLURM commands and resource requests, see [SLURM Basics](09_slurm_basics.md).

---

## 1. General workflow

Most computational analyses on WSP follow the same steps:

1. Prepare input files and organize the project directory.
2. Check that the required software is available.
3. Create a SLURM job script.
4. Specify CPU, memory, and runtime requirements.
5. Load the required software environment.
6. Submit the job using `sbatch`.
7. Monitor its progress.
8. Check the results and job logs.

Large analyses should not be run directly in interactive SSH sessions.

## 2. Organizing a project

A suggested project structure is:

```text
/scratch/USERNAME/my_project/
├── data/
├── reference/
├── scripts/
├── results/
└── logs/
```

The directories serve different purposes:

| Directory | Contents |
|---|---|
| `data/` | Input datasets |
| `reference/` | Reference genomes and annotations |
| `scripts/` | Analysis scripts and SLURM job files |
| `results/` | Analysis outputs |
| `logs/` | Standard output and error logs |

Create the directories:

```bash
mkdir -p data reference scripts results logs
```

Use absolute paths or explicitly set the working directory in job scripts to avoid confusion.

**Important:** `/scratch` is working storage, not permanent archival storage. Keep important research data backed up elsewhere.

---

## 3. Checking available software

WSP uses Lmod to manage centrally installed scientific software.

List available modules:

```bash
module avail
```

Search for a specific program:

```bash
module spider samtools
```

Load a version:

```bash
module load samtools/1.25
```

Verify the executable:

```bash
command -v samtools
samtools --version
```

Software modules should also be loaded inside SLURM job scripts.

For software that is not available centrally, users may use personal Conda environments or Python virtual environments.

See [Installing Software](04_installing_software.md) and [Conda and Software Environments](05_conda_and_environments.md).

---

## 4. Example: BWA read alignment

BWA can align short sequencing reads to a reference genome.

This example assumes that the reference genome has already been indexed using `bwa index`.

Create a file named `bwa_alignment.sh`:

```bash
#!/bin/bash
#SBATCH --job-name=bwa_alignment
#SBATCH --partition=main
#SBATCH --cpus-per-task=8
#SBATCH --mem=16G
#SBATCH --time=12:00:00
#SBATCH --output=bwa_%j.out
#SBATCH --error=bwa_%j.err

set -euo pipefail

source /etc/profile.d/lmod.sh
module load bwa/0.7.19
module load samtools/1.25

bwa mem \
    -t "$SLURM_CPUS_PER_TASK" \
    reference/genome.fa \
    data/sample_R1.fastq.gz \
    data/sample_R2.fastq.gz \
    | samtools sort \
        -@ "$SLURM_CPUS_PER_TASK" \
        -o results/sample.sorted.bam -

samtools index results/sample.sorted.bam
```

Submit the job:

```bash
sbatch bwa_alignment.sh
```

The script creates a coordinate-sorted BAM file and its index.

The requested resources are examples, not universal requirements. Adjust them according to the dataset and reference genome.

Note that piping BWA into Samtools allows both programs to use threads concurrently. CPU and memory allocations should account for the combined workload.

---

## 5. Example: Samtools processing

Samtools can be used to sort, index, and inspect alignment files.

Create `samtools_sort.sh`:

```bash
#!/bin/bash
#SBATCH --job-name=samtools_sort
#SBATCH --partition=main
#SBATCH --cpus-per-task=4
#SBATCH --mem=8G
#SBATCH --time=04:00:00
#SBATCH --output=samtools_%j.out
#SBATCH --error=samtools_%j.err

set -euo pipefail

source /etc/profile.d/lmod.sh
module load samtools/1.25

samtools sort \
    -@ "$SLURM_CPUS_PER_TASK" \
    -o results/sample.sorted.bam \
    data/sample.bam

samtools index results/sample.sorted.bam

samtools flagstat results/sample.sorted.bam \
    > results/sample.flagstat.txt
```

Submit:

```bash
sbatch samtools_sort.sh
```

This produces a sorted BAM file, a BAM index, and an alignment statistics report.

---

## 6. Example: Running R scripts

R analyses can also be submitted through SLURM.

Create an R script named `analysis.R`:

```r
data <- c(4, 8, 12, 16, 20)

result <- mean(data)

cat("Mean:", result, "\n")
```

Create `r_analysis.sh`:

```bash
#!/bin/bash
#SBATCH --job-name=r_analysis
#SBATCH --partition=main
#SBATCH --cpus-per-task=2
#SBATCH --mem=8G
#SBATCH --time=02:00:00
#SBATCH --output=r_%j.out
#SBATCH --error=r_%j.err

set -euo pipefail

source /etc/profile.d/lmod.sh
module load R/4.6.2

Rscript analysis.R
```

Submit:

```bash
sbatch r_analysis.sh
```

R does not automatically use all requested CPUs. Parallel analyses must be configured appropriately within the R code.

---

## 7. Example: Running Snakemake

Snakemake is a workflow management system used to organize multi-step computational pipelines.

WSP has Snakemake 9.27.1 available through Lmod.

A basic SLURM script for running a small Snakemake workflow locally within one allocated job is:

```bash
#!/bin/bash
#SBATCH --job-name=snakemake
#SBATCH --partition=main
#SBATCH --cpus-per-task=8
#SBATCH --mem=16G
#SBATCH --time=12:00:00
#SBATCH --output=snakemake_%j.out
#SBATCH --error=snakemake_%j.err

set -euo pipefail

source /etc/profile.d/lmod.sh
module load snakemake/9.27.1

snakemake \
    --snakefile Snakefile \
    --cores "$SLURM_CPUS_PER_TASK"
```

Submit:

```bash
sbatch snakemake.sh
```

This runs Snakemake inside a single SLURM allocation.

**Important:** This is different from configuring Snakemake to submit each workflow rule as a separate SLURM job. That requires a suitable Snakemake executor configuration and is not covered by this introductory example.

---

## 8. Example: Running Singularity containers

Singularity CE allows users to run software inside containers without installing every dependency directly on WSP.

WSP provides Singularity CE 4.6.0 through Lmod.

Load the module:

```bash
module load singularity/4.6.0
```

Verify the version:

```bash
singularity --version
```

A basic SLURM job script is:

```bash
#!/bin/bash
#SBATCH --job-name=container_example
#SBATCH --partition=main
#SBATCH --cpus-per-task=2
#SBATCH --mem=4G
#SBATCH --time=01:00:00
#SBATCH --output=container_%j.out
#SBATCH --error=container_%j.err

set -euo pipefail

source /etc/profile.d/lmod.sh
module load singularity/4.6.0

singularity exec \
    /path/to/container.sif \
    echo "Hello from a container"
```

Replace `/path/to/container.sif` with an existing container image.

Container execution should be tested on WSP before relying on it for production analyses.

Containerized programs remain subject to their SLURM resource allocations.

---

## 9. Running software from Conda environments

If a program is not available through Lmod, users may run it from a personal Conda environment.

Example:

```bash
#!/bin/bash
#SBATCH --job-name=conda_analysis
#SBATCH --partition=main
#SBATCH --cpus-per-task=4
#SBATCH --mem=8G
#SBATCH --time=04:00:00
#SBATCH --output=conda_%j.out
#SBATCH --error=conda_%j.err

set -euo pipefail

source "$HOME/miniconda3/etc/profile.d/conda.sh"

conda activate my_environment

PROGRAM
```

Replace the initialization path, environment name, and program command as appropriate.

Avoid mixing conflicting Conda packages and Lmod modules.

---

## 10. Monitoring analyses

After submitting a job, SLURM returns a job ID.

For example:

```text
Submitted batch job 12345
```

View your running and pending jobs:

```bash
squeue -u "$USER"
```

Inspect a specific job:

```bash
scontrol show job 12345
```

View accounting information:

```bash
sacct -j 12345 --format=JobID,JobName,State,Elapsed,ExitCode,MaxRSS
```

Cancel a job:

```bash
scancel 12345
```

Replace `12345` with the actual job ID.

See [Monitoring SLURM Jobs](10_monitoring_jobs.md) for additional commands.

---

## 11. Checking results and logs

SLURM job scripts can save standard output and error messages to separate files.

Recommended directives:

```bash
#SBATCH --output=%x_%j.out
#SBATCH --error=%x_%j.err
```

Where `%x` represents the job name and `%j` represents the job ID.

For example:

```text
bwa_alignment_12345.out
bwa_alignment_12345.err
```

After a job finishes:

1. Check its SLURM state and exit code.
2. Read the output and error logs.
3. Verify that the expected result files exist.
4. Check that the results are complete and valid.
5. Record the software versions and parameters used.

A job finishing successfully does not necessarily guarantee that its scientific output is correct.

---

## 12. Common problems

### Program not found

Check the loaded modules:

```bash
module list
```

Search for the software:

```bash
module spider PROGRAM
```

Make sure the required module is loaded inside the SLURM script.

### Job remains pending

Check the scheduling reason:

```bash
squeue -j JOB_ID -o "%.18i %.9T %.30R"
```

The job may be waiting for resources or affected by scheduling limits.

### Job runs out of memory

Review the memory allocation and recorded usage:

```bash
sacct -j JOB_ID --format=JobID,State,MaxRSS,ReqMem
```

Increase the requested memory only when justified by the workload.

### Job exceeds its time limit

Review the runtime:

```bash
sacct -j JOB_ID --format=JobID,State,Elapsed,Timelimit
```

Adjust the wall-time request if necessary, within the configured WSP limits.

### Files cannot be found

Check whether the script uses relative paths.

SLURM batch jobs normally start in the directory from which `sbatch` was submitted, unless another working directory is specified.

You can set the working directory explicitly:

```bash
#SBATCH --chdir=/scratch/USERNAME/my_project
```

Make sure required input files exist and output directories have been created before submitting the job.

---

## 13. Good practices

- Submit computationally intensive analyses through SLURM.
- Use existing Lmod modules whenever possible.
- Request realistic CPU, memory, and runtime allocations.
- Match software thread counts to allocated resources.
- Keep job scripts with the corresponding project.
- Use descriptive job names.
- Save standard output and error logs.
- Check job completion and validate results.
- Record software versions and analysis parameters.
- Avoid unnecessary duplicate data and intermediate files.
- Back up important results outside scratch storage.
- Do not modify shared software installations without authorization.

Following these practices helps keep computational analyses reproducible while ensuring WSP remains available to other researchers.

---

## Related documentation

- [SLURM Basics](09_slurm_basics.md)
- [Monitoring SLURM Jobs](10_monitoring_jobs.md)
- [Installing Software](04_installing_software.md)
- [Conda and Software Environments](05_conda_and_environments.md)
- [Troubleshooting WSP](11_troubleshooting.md)
- [WSP Usage Policy](12_wsp_usage_policy.md)
