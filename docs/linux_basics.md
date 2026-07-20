# Linux Basics

You do not need to become a Linux expert to use WSP effectively. Most day-to-day work involves navigating directories, organizing files, running software, and inspecting results.

This guide introduces the commands you'll use most often while working on WSP and explains when you are likely to use them.

---

# Navigating the filesystem

The Linux filesystem is organized as a single directory tree. When you log into WSP, you begin in your home directory.

### `pwd`

Prints your current working directory.

```bash
pwd
```

Example output:

```text
/home/username
```

If you ever become unsure where you are, `pwd` is the quickest way to find out.

### `ls`

Lists the contents of your current directory.

```bash
ls
```

Useful options:

```bash
ls -l
```

Shows detailed information including permissions, owner, size, and modification date.

```bash
ls -lh
```

Displays file sizes in a human-readable format.

```bash
ls -a
```

Shows hidden files, including configuration files such as `.bashrc`.

### `cd`

Changes your current directory.

```bash
cd project
```

Useful shortcuts:

```bash
cd ..
```

Move to the parent directory.

```bash
cd ~
```

Return to your home directory.

```bash
cd -
```

Return to the previous directory.

> **Tip**
>
> Press **Tab** to auto-complete filenames and directories instead of typing them in full.

---

# Creating and organizing files

### `mkdir`

Creates a new directory.

```bash
mkdir project
```

You can also create multiple directories at once.

```bash
mkdir data scripts results
```

### `cp`

Copies files or directories.

Copy a file:

```bash
cp file.txt destination/
```

Copy an entire directory:

```bash
cp -r project destination/
```

### `mv`

Moves or renames files.

Rename a file:

```bash
mv old_name.txt new_name.txt
```

Move a file into another directory:

```bash
mv file.txt results/
```

Linux uses the same command for moving and renaming.

### `rm`

Removes files or directories.

Delete a file:

```bash
rm file.txt
```

Delete an entire directory:

```bash
rm -r folder
```

> **Warning**
>
> Deleted files do not go to a recycle bin. Double-check before pressing Enter.

---

# Viewing files

Most bioinformatics data are plain text files. Linux provides several tools for viewing them.

### `cat`

Displays the entire contents of a file.

```bash
cat file.txt
```

Useful for short text files such as configuration files or small scripts.

### `less`

Opens a file in a scrollable viewer.

```bash
less file.txt
```

Navigate with the arrow keys and press **q** to quit.

This is usually the best choice for large files.

### `head`

Displays the first 10 lines of a file.

```bash
head reads.fastq
```

Specify the number of lines:

```bash
head -20 reads.fastq
```

Useful for checking file formats or confirming that a download completed correctly.

### `tail`

Displays the last 10 lines of a file.

```bash
tail logfile.txt
```

Specify the number of lines:

```bash
tail -50 logfile.txt
```

This is particularly useful for checking log files after a program finishes running.

---

# Finding information

### `find`

Searches for files by name.

```bash
find . -name "*.fastq.gz"
```

Searches the current directory and all subdirectories.

### `grep`

Searches for text within files.

```bash
grep "gene" annotation.gff
```

Useful options:

```bash
grep -i "gene" annotation.gff
```

Ignore uppercase and lowercase differences.

```bash
grep -n "gene" annotation.gff
```

Display matching line numbers.

### `wc`

Counts lines, words, and characters.

```bash
wc genes.txt
```

Count only lines:

```bash
wc -l genes.txt
```

This is useful for quickly estimating the number of records in many text files.

### `sort`

Sorts lines alphabetically.

```bash
sort genes.txt
```

Sort numerically:

```bash
sort -n values.txt
```

Sorting is commonly used before comparing files or removing duplicate entries.

---

# Working with compressed files

Many sequencing datasets are compressed using the `.gz` format. These files can often be viewed without decompressing them.

View the beginning of a compressed file:

```bash
zcat reads.fastq.gz | head
```

Read a compressed text file interactively:

```bash
zless reads.fastq.gz
```

---

# Monitoring storage

### `du`

Shows how much disk space a directory uses.

```bash
du -sh project/
```

### `df`

Shows available disk space.

```bash
df -h
```

These commands are useful if analyses fail because a filesystem is full.

---

# Command history

Linux remembers every command you run.

View your command history:

```bash
history
```

Repeat the previous command:

```bash
!!
```

You can also use the **Up Arrow** and **Down Arrow** keys to cycle through recent commands.

---

# Getting help

Most Linux commands include built-in documentation.

```bash
man ls
```

or

```bash
ls --help
```

Most bioinformatics software also supports the `--help` option.

---

# Useful keyboard shortcuts

| Shortcut | Function |
|-----------|----------|
| Tab | Auto-complete filenames and directories |
| Ctrl + C | Stop the current command |
| Ctrl + L | Clear the terminal |
| Up / Down Arrow | Browse command history |
| Ctrl + R | Search command history |
| Ctrl + A | Move cursor to the beginning of the line |
| Ctrl + E | Move cursor to the end of the line |
| Ctrl + U | Delete everything before the cursor |
| Ctrl + K | Delete everything after the cursor |

Learning just a few of these shortcuts can make working in the terminal much faster.
