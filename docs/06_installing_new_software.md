# Installing Software on WSP

WSP provides a collection of scientific software available to all researchers.

Many programs are installed centrally and managed through **Lmod**, a software environment management system that allows users to load specific versions of programs.

Users can also install additional software in their own accounts when a program or version isn't available centrally.

Because regular users don't have administrator (root) privileges, place personal installations in directories where they have write access, such as their home directory.

This guide explains how to find existing software, use Lmod modules, and install additional programs when necessary.

---

# Before installing anything

**Always check whether the software is already available on WSP.**

There are two main ways to do this.

## 1. Check available software modules

```bash
module avail
```

This lists software versions available through Lmod.

To search for a particular program:

```bash
module spider samtools
```

If the software is available, load the required version:

```bash
module load samtools/1.25
```

Verify the installation:

```bash
samtools --version
```

## 2. Check whether a program is already in your PATH

Some software may be installed without an Lmod module.

For example:

```bash
command -v fastqc
```

Or:

```bash
fastqc --version
```

The first command shows the executable location, while the second checks whether the program can run and report its version.

A program may be installed even if `command -v` does not find it, particularly when its module has not been loaded.

> **Tip:** Avoid installing duplicate copies of software unnecessarily. This wastes storage space and can confuse which version is being used.

---

# Using Lmod software modules

Lmod allows multiple versions of the same software to coexist without users needing to manually configure their installation paths.

## View available modules

```bash
module avail
```

## Search for software

```bash
module spider gatk
```

## Load a specific version

```bash
module load gatk/4.7.0.0
```

## View loaded modules

```bash
module list
```

## Unload a module

```bash
module unload gatk/4.7.0.0
```

## Switch versions

For example, to switch between two Samtools versions:

```bash
module swap samtools/1.25 samtools/1.11
```

Some software modules cannot be loaded simultaneously because they provide conflicting environments.

## Available software

Examples of software configured through Lmod on WSP include:

| Software | Available versions |
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

This list is not exhaustive and may change as software is updated.

Use `module avail` to see the currently available modules.

---

# Choosing an installation method

If the software is not available through Lmod or an existing installation, you may need to install it yourself.

| Method | Best for |
|---|---|
| Lmod | Using software already installed centrally on WSP |
| Conda / Mamba | Managing personal bioinformatics environments and dependencies |
| Python virtual environments | Installing Python-based tools |
| Standalone binaries | Programs distributed as executable files |
| Compiling from source | Software without suitable precompiled packages |

For most users, **Lmod should be the first choice**, followed by Conda or Mamba when a personal installation is necessary.

If software would be useful to multiple researchers, consider asking the WSP administrators whether it can install it centrally.

---

# Installing standalone programs

Some programs are distributed as standalone executable files.

A common location for personal executables is:

```text
~/bin
```

Create this directory if necessary:

```bash
mkdir -p ~/bin
```

Add it to your PATH by adding the following line to your shell configuration file (`~/.zshrc` if you use Zsh):

```bash
export PATH="$HOME/bin:$PATH"
```

Reload your shell configuration:

```bash
source ~/.zshrc
```

Verify that the directory is included:

```bash
echo "$PATH"
```

Be aware that personal executables in `~/bin` may take precedence over centrally installed programs, depending on the order of directories in your PATH.

Use `command -v PROGRAM` to check which executable is being selected.

---

# Example: Installing the NCBI Datasets CLI

If the NCBI Datasets CLI is not already available on WSP, you can install it in your personal `~/bin` directory.

Download the executable:

```bash
mkdir -p ~/bin
cd ~/bin

wget https://ftp.ncbi.nlm.nih.gov/pub/datasets/command-line/LATEST/linux-amd64/datasets
```

Make it executable:

```bash
chmod +x datasets
```

Verify the installation:

```bash
datasets version
```

You can now use the program from any directory, provided `~/bin` is in your PATH.

For example:

```bash
datasets download genome accession GCA_041902855.1 \
    --include genome,gff3,rna,protein,cds,seq-report
```

---

# Installing software with Conda

Conda and Mamba can install bioinformatics software and manage its dependencies without administrator privileges.

Before creating an environment, check whether Conda or Mamba is available:

```bash
command -v conda
```

or:

```bash
command -v mamba
```

If Conda is available and initialized, create a new environment:

```bash
conda create -n rnaseq
```

Activate it:

```bash
conda activate rnaseq
```

Install software from the appropriate channels:

```bash
conda install -c conda-forge -c bioconda fastqc
```

Verify the installation:

```bash
fastqc --version
```

Deactivate the environment when finished:

```bash
conda deactivate
```

Separate environments help prevent conflicts between different software versions and dependencies.

Avoid unnecessarily mixing Conda environments with centrally installed Lmod software modules, particularly when both provide the same program or conflicting libraries.

See [Conda and Environments](05_conda_and_environments.md) for more information.

---

# Installing Python software with virtual environments

Python virtual environments provide another way to install software without administrator privileges.

For example, create an environment:

```bash
python3 -m venv ~/software/mytool-venv
```

Activate it:

```bash
source ~/software/mytool-venv/bin/activate
```

Install a Python package:

```bash
python -m pip install PACKAGE_NAME
```

Deactivate the environment:

```bash
deactivate
```

Virtual environments are particularly useful for Python-based tools not available through WSP's existing software modules.

Avoid installing Python packages into the system-wide Python environment.

---

# Running installed software through SLURM

Submit computationally intensive analyses through SLURM.

When using centrally installed software, load the required modules inside the job script.

For example:

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

Submit the script using:

```bash
sbatch job.sh
```

Explicitly loading software versions inside job scripts improves reproducibility and helps prevent differences between interactive and batch environments.

For additional information, see the SLURM Basics guide.

---

# Keeping software organized

Keep personal software installations separate from project data and temporary analysis files.

A suggested directory structure is:

```text
~/software/
~/bin/
~/miniconda3/
~/reference/
```

For example:

- `~/software/` for manually installed programs and virtual environments.
- `~/bin/` for personal executable scripts and standalone programs.
- `~/miniconda3/` for a personal Conda installation, if used.
- `~/reference/` for reference files, when appropriate.

Avoid installing permanent software in scratch directories, which are intended for computational working data.

---

# Troubleshooting

## A program is installed but cannot be found

First check whether an Lmod module is available:

```bash
module spider PROGRAM
```

Then check which executable is selected:

```bash
command -v PROGRAM
```

If the program was installed in a Conda environment or Python virtual environment, make sure the appropriate environment is activated.

## The wrong software version is running

Check the executable location:

```bash
command -v PROGRAM
```

Check loaded modules:

```bash
module list
```

Load the required software version explicitly.

Be aware that older executables in directories such as `/usr/local/bin` may still exist alongside newer installations.

## A module cannot be loaded

Check whether the requested version exists:

```bash
module avail
```

For more detailed information:

```bash
module spider PROGRAM
```

If the module is listed but fails to load or run, contact the WSP administrators with the command and error message.

## Software works in the terminal but not in SLURM

Make sure the required module or environment is initialized inside the SLURM job script.

For Lmod:

```bash
source /etc/profile.d/lmod.sh
module load PROGRAM/VERSION
```

For Conda, initialize Conda and activate the appropriate environment inside the script.

---

# Good practices

- Check Lmod modules before installing software.
- Use existing shared installations whenever possible.
- Load specific software versions for reproducible analyses.
- Use Conda, Mamba, or virtual environments for personal installations.
- Install standalone executables in `~/bin`.
- Avoid modifying system-wide software installations.
- Keep permanent software outside scratch directories.
- Record software versions and environment information in analysis scripts.
- Load software environments explicitly inside SLURM job scripts.
- Contact WSP administrators if software would benefit multiple users.

Following these practices helps keep WSP organized, reproducible, and accessible to everyone.
