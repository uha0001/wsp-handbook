# SLURM Job Examples

This page contains example SLURM scripts for common computational and
bioinformatics analyses on WSP.

> **Important**
>
> The resource requests below are examples only. Actual CPU, memory, and runtime
> requirements depend on the software, dataset size, reference genome, and
> analysis.

Users should adjust resource requests according to their needs and the WSP
resource policy.

---

## General SLURM Template

```bash
#!/bin/bash

#SBATCH --job-name=my_analysis
#SBATCH --cpus-per-task=4
#SBATCH --mem=8G
#SBATCH --time=02:00:00
#SBATCH --output=%x_%j.out
#SBATCH --error=%x_%j.err

# Activate software/environment if required

# Run analysis
```

Save the script, for example as:

```text
analysis.sh
```

Submit it with:

```bash
sbatch analysis.sh
```

---

## FastQC

```bash
#!/bin/bash

#SBATCH --job-name=fastqc
#SBATCH --cpus-per-task=4
#SBATCH --mem=8G
#SBATCH --time=02:00:00
#SBATCH --output=%x_%j.out
#SBATCH --error=%x_%j.err

fastqc \
    --threads 4 \
    sample_R1.fastq.gz \
    sample_R2.fastq.gz
```

---

## fastp

```bash
#!/bin/bash

#SBATCH --job-name=fastp
#SBATCH --cpus-per-task=4
#SBATCH --mem=8G
#SBATCH --time=02:00:00
#SBATCH --output=%x_%j.out
#SBATCH --error=%x_%j.err

fastp \
    --thread 4 \
    --in1 sample_R1.fastq.gz \
    --in2 sample_R2.fastq.gz \
    --out1 sample_R1.trimmed.fastq.gz \
    --out2 sample_R2.trimmed.fastq.gz \
    --html sample_fastp.html \
    --json sample_fastp.json
```

---

## HISAT2

```bash
#!/bin/bash

#SBATCH --job-name=hisat2
#SBATCH --cpus-per-task=8
#SBATCH --mem=32G
#SBATCH --time=12:00:00
#SBATCH --output=%x_%j.out
#SBATCH --error=%x_%j.err

hisat2 \
    -p 8 \
    -x reference/index \
    -1 sample_R1.fastq.gz \
    -2 sample_R2.fastq.gz \
    -S sample.sam
```

The number passed to HISAT2 with:

```text
-p
```

should normally match:

```bash
#SBATCH --cpus-per-task
```

---

## samtools sort

```bash
#!/bin/bash

#SBATCH --job-name=samtools_sort
#SBATCH --cpus-per-task=8
#SBATCH --mem=16G
#SBATCH --time=04:00:00
#SBATCH --output=%x_%j.out
#SBATCH --error=%x_%j.err

samtools sort \
    -@ 8 \
    -o sample.sorted.bam \
    sample.bam
```

---

## samtools index

```bash
#!/bin/bash

#SBATCH --job-name=samtools_index
#SBATCH --cpus-per-task=2
#SBATCH --mem=4G
#SBATCH --time=01:00:00
#SBATCH --output=%x_%j.out
#SBATCH --error=%x_%j.err

samtools index sample.sorted.bam
```

---

## featureCounts

```bash
#!/bin/bash

#SBATCH --job-name=featurecounts
#SBATCH --cpus-per-task=8
#SBATCH --mem=16G
#SBATCH --time=04:00:00
#SBATCH --output=%x_%j.out
#SBATCH --error=%x_%j.err

featureCounts \
    -T 8 \
    -a annotation.gtf \
    -o counts.txt \
    sample.sorted.bam
```

Check the appropriate featureCounts options for paired-end or strand-specific
libraries.

---

## Running an R Script

```bash
#!/bin/bash

#SBATCH --job-name=R_analysis
#SBATCH --cpus-per-task=2
#SBATCH --mem=16G
#SBATCH --time=04:00:00
#SBATCH --output=%x_%j.out
#SBATCH --error=%x_%j.err

Rscript analysis.R
```

---

## Running a Python Script

```bash
#!/bin/bash

#SBATCH --job-name=python_analysis
#SBATCH --cpus-per-task=2
#SBATCH --mem=8G
#SBATCH --time=02:00:00
#SBATCH --output=%x_%j.out
#SBATCH --error=%x_%j.err

python3 analysis.py
```

---

## Using Conda in a SLURM Job

```bash
#!/bin/bash

#SBATCH --job-name=conda_job
#SBATCH --cpus-per-task=4
#SBATCH --mem=8G
#SBATCH --time=02:00:00
#SBATCH --output=%x_%j.out
#SBATCH --error=%x_%j.err

source ~/miniconda3/etc/profile.d/conda.sh
conda activate my_environment

PROGRAM
```

Replace the environment name and Conda path with the appropriate values for
your account.

See:

[Conda and Environments](05_conda_and_environments.md)

---

## Job Arrays

Job arrays are useful when the same analysis must be run on many samples.

Example:

```bash
#!/bin/bash

#SBATCH --job-name=fastqc_array
#SBATCH --array=0-9
#SBATCH --cpus-per-task=4
#SBATCH --mem=8G
#SBATCH --time=02:00:00
#SBATCH --output=%x_%A_%a.out
#SBATCH --error=%x_%A_%a.err

SAMPLES=(
sample01
sample02
sample03
sample04
sample05
sample06
sample07
sample08
sample09
sample10
)

SAMPLE=${SAMPLES[$SLURM_ARRAY_TASK_ID]}

fastqc \
    --threads 4 \
    "${SAMPLE}_R1.fastq.gz" \
    "${SAMPLE}_R2.fastq.gz"
```

Here:

- `%A` = array job ID
- `%a` = array task ID
- `$SLURM_ARRAY_TASK_ID` = current task number

For larger projects, using a sample list or metadata file is usually preferable
to manually writing long arrays.

---

## Before Submitting a Large Job

Check:

- input files are correct
- sufficient `/scratch` space is available
- required software is available
- the program can use the requested CPUs
- memory request is reasonable
- wall-time request is reasonable
- output and error files are defined

Whenever possible, test a workflow on a small subset of the data before running
the complete analysis.
