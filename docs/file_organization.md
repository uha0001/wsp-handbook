# File Organization

Good file organization is one of the simplest ways to make your research more reproducible and easier to maintain. A well-organized project is easier to understand, troubleshoot, and share with collaborators.

This guide explains where different types of files should be stored on WSP and offers suggestions for keeping projects organized.

---

# Understanding WSP storage

WSP provides two main storage locations with different purposes.

## Home directory (`$HOME`)

Your home directory is intended for files that are relatively small but important.

Examples include:

- scripts
- software you have installed
- configuration files
- documentation
- reference datasets
- final analysis results

Example:

```text
/home/username/
├── miniconda3/
├── scripts/
│   ├── run_fastqc.sh
│   └── trim_reads.sh
├── reference/
│   └── GCA_001045655.1.fa
├── README.md
└── final_results/
```

Your home directory is backed up periodically, making it the safest place for files you cannot easily recreate.

Because storage space is limited, avoid storing large sequencing datasets or intermediate analysis files here.

---

## Scratch storage

Your scratch directory is designed for computational work and large datasets.

Typical contents include:

- raw sequencing data
- trimmed reads
- alignment files
- temporary outputs
- intermediate analysis files
- large project directories

Example:

```text
/scratch/username/
└── formicitoxin/
    ├── raw_data/
    ├── trimmed/
    ├── alignments/
    ├── counts/
    ├── logs/
    └── results/
```

Scratch provides considerably more storage than your home directory, but **it is not backed up**.

> **Warning**
>
> Never keep the only copy of important data on scratch. If a file cannot be recreated, make sure another copy exists elsewhere.

---

# Organizing a project

There is currently no standard project structure across the lab, so you're free to organize your work in a way that makes sense for your project.

One possible layout is shown below.

```text
project_name/
├── metadata/
├── raw_data/
├── processed_data/
├── scripts/
├── results/
├── figures/
├── logs/
└── README.md
```

A possible project might look like this:

```text
formicitoxin/
├── metadata/
│   ├── sample_sheet.csv
│   └── experimental_design.xlsx
├── raw_data/
│   ├── SRR34408630_1.fastq.gz
│   └── SRR34408630_2.fastq.gz
├── processed_data/
│   ├── trimmed/
│   └── alignments/
├── scripts/
│   ├── 01_download.sh
│   ├── 02_fastqc.sh
│   ├── 03_trim.sh
│   └── 04_align.sh
├── logs/
│   ├── fastqc.log
│   └── hisat2.log
├── results/
│   ├── counts.tsv
│   └── differential_expression.csv
└── README.md
```

This is only an example. The most important thing is to use a structure that is logical and consistent.

---

# Protect your raw data

As a general rule, **never modify your raw data directly**.

For example, instead of replacing your original FASTQ files after trimming:

❌

```text
raw_data/
└── sample1.fastq.gz
```

(after trimming, the original file is gone)

Keep the original data unchanged and save processed files separately:

✔

```text
raw_data/
└── sample1.fastq.gz

processed_data/
└── sample1_trimmed.fastq.gz
```

This makes it much easier to reproduce analyses or restart a project if something goes wrong.

---

# Naming files

Good filenames make projects much easier to navigate.

Avoid generic names such as:

```text
results.csv
results_final.csv
results_final2.csv
new_results.csv
```

Instead, use names that describe the contents:

```text
expression_counts_day7.csv
expression_counts_day14.csv
hisat2_alignment_summary.txt
fastqc_report_sample01.html
```

Some general recommendations:

- use descriptive names
- avoid spaces in filenames
- use underscores (`_`) or hyphens (`-`) instead of spaces
- include dates or version numbers when appropriate
- use consistent naming throughout a project

---

# Keep analysis code separate from data

Keeping scripts separate from datasets makes projects easier to understand and reduces the chance of accidentally modifying important files.

For example:

```text
project_name/
├── raw_data/
├── processed_data/
├── scripts/
│   ├── run_fastqc.sh
│   ├── trim_reads.sh
│   └── align_reads.sh
└── results/
```

Instead of storing scripts alongside your sequencing files:

```text
raw_data/
├── sample1.fastq.gz
├── sample2.fastq.gz
├── align.sh
├── trim.sh
├── test.sh
└── final_script.sh
```

---

# Document your work

Every project should contain a short `README.md` file describing:

- what the project is about
- where the data came from
- how analyses were performed
- important scripts
- software versions (if relevant)

A simple README might look like this:

```markdown
# Formicitoxin RNA-seq

Project investigating venom gland gene expression in Formicinae ants.

## Data
Downloaded from NCBI SRA (BioProject PRJNA...)

## Pipeline

1. FastQC
2. fastp
3. HISAT2
4. featureCounts

Reference genome:
GCA_001045655.1

Created: July 2026
```

Even a few sentences can save a surprising amount of time when returning to a project months later.

---

# Good habits

Small habits early in a project often prevent major confusion later.

- Keep related files together.
- Use meaningful directory names.
- Keep raw data unchanged.
- Store large datasets in scratch.
- Keep scripts under version control whenever possible.
- Save log files from important analyses.
- Remove temporary files when they are no longer needed.
- Keep a README for every project.

> **Tip**
>
> Organize your project so that someone unfamiliar with your work could understand where everything belongs. Six months from now, that "someone" is often you.
