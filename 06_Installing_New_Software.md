# 4. Installing user software

Some tools are not installed system-wide or may become unavailable over time.
To install software without administrator privileges, create a personal `~/bin`
directory and add it to your PATH.

## Add ~/bin to your PATH

```bash
mkdir -p ~/bin
echo 'export PATH="$HOME/bin:$PATH"' >> ~/.zshrc
source ~/.zshrc
```

Verify:

```bash
echo $PATH
```

---

## Example: Installing the NCBI Datasets CLI

```bash
cd ~/bin

wget https://ftp.ncbi.nlm.nih.gov/pub/datasets/command-line/LATEST/linux-amd64/datasets

chmod +x datasets

datasets version
```

Example download:

```bash
cd ~/scratch/<username>/<project>/genome

datasets download genome accession GCA_041902855.1 \
    --include genome,gff3,rna,protein,cds,seq-report
```
