# Installing Software

Not all software is installed system-wide on WSP. In many cases, you'll need to install software yourself within your own user account.

Since users do not have administrator (root) privileges, software must be installed in locations where you have write access, such as your home directory.

This guide introduces the most common approaches for installing software on WSP.

---

# Before installing anything

Before installing a new program, first check whether it is already available.

```bash
which fastqc
```

or

```bash
fastqc --version
```

If the program is already installed, there is no need to install another copy.

> **Tip**
>
> Installing duplicate copies of software wastes storage space and can make it difficult to keep track of which version you are using.

---

# Choosing an installation method

There is no single way to install software on Linux. The appropriate method depends on how the software is distributed.

| Method | Best for |
|---------|----------|
| Conda / Mamba | Most bioinformatics software |
| Downloading standalone binaries | Small utilities distributed as a single executable |
| Compiling from source | Software that is not otherwise available |

Whenever possible, we recommend using Conda or Mamba because they automatically install required dependencies.

---

# Installing standalone programs

Some programs are distributed as a single executable file that can simply be downloaded and placed in a directory included in your PATH.

A common location is:

```text
~/bin
```

If the directory does not already exist:

```bash
mkdir -p ~/bin
```

Add it to your PATH by adding the following line to your shell configuration file (`~/.zshrc`):

```bash
export PATH="$HOME/bin:$PATH"
```

Reload your shell:

```bash
source ~/.zshrc
```

Verify that the directory has been added:

```bash
echo $PATH
```

---

# Example: Installing the NCBI Datasets CLI

Download the executable:

```bash
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

You can now use it from any directory.

For example:

```bash
datasets download genome accession GCA_041902855.1 \
    --include genome,gff3,rna,protein,cds,seq-report
```

---

# Installing software with Conda

Many bioinformatics programs are available through Conda.

Create a new environment:

```bash
conda create -n rnaseq
```

Activate it:

```bash
conda activate rnaseq
```

Install software:

```bash
conda install fastqc
```

Deactivate the environment:

```bash
conda deactivate
```

Using separate environments helps prevent conflicts between different software versions.

---

# Keeping software organized

As you install more software, it helps to keep your home directory organized.

For example:

```text
~/software/
~/bin/
~/miniconda3/
~/reference/
```

Keeping software, scripts, and reference data in separate locations makes projects easier to manage.

---

# Good practices

- Check whether software is already installed before installing your own copy.
- Prefer Conda or Mamba for bioinformatics software whenever possible.
- Install standalone executables in `~/bin`.
- Keep software in your home directory rather than scratch.
- Record software versions used in your analyses.
