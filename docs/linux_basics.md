# Linux Basics

You do not need to become a Linux expert to use WSP effectively. Most day-to-day work involves navigating directories, organizing files, running software, and inspecting results.

This guide introduces the commands you'll use most often while working on WSP.

---

# Understanding the Linux filesystem

Unlike Windows, Linux organizes files into a single directory tree.

When you log into WSP, you begin in your **home directory**.

To see your current location, run:

```bash
pwd
```

Typical output:

```text
/home/ulku
```

This command is useful whenever you're unsure where you are.

> **Tip**
>
> Getting lost in the filesystem happens to everyone. Running `pwd` is the quickest way to orient yourself.

---

# Viewing files and directories

To see the contents of your current directory:

```bash
ls
```

Useful variations include:

```bash
ls -l
```

Displays files in a detailed list, including permissions, owner, size, and modification date.

```bash
ls -lh
```

Shows file sizes in a human-readable format (KB, MB, GB).

```bash
ls -a
```

Displays hidden files, including configuration files beginning with a period (`.`).

> **Tip**
>
> Many important configuration files are hidden. If you can't find `.bashrc` or `.profile`, try using `ls -a`.

---

# Moving around the filesystem

Change into another directory:

```bash
cd project
```

Move back one directory:

```bash
cd ..
```

Return to your home directory:

```bash
cd ~
```

Go to the previous directory:

```bash
cd -
```

> **Tip**
>
> The `Tab` key will automatically complete file and directory names. Instead of typing a long folder name, type the first few letters and press **Tab**.

---

# Creating folders

Create a new directory:

```bash
mkdir project
```

Create several directories at once:

```bash
mkdir scripts data results
```

A well-organized project is much easier to maintain than one containing hundreds of files in a single folder.

---

# Copying, moving and renaming

Copy a file:

```bash
cp file.txt destination/
```

Copy an entire directory:

```bash
cp -r project destination/
```

Rename a file:

```bash
mv old_name.txt new_name.txt
```

Move a file:

```bash
mv file.txt results/
```

Unlike Windows, Linux uses the same command (`mv`) for both moving and renaming files.

---

# Removing files

Delete a file:

```bash
rm file.txt
```

Delete a directory and everything inside it:

```bash
rm -r folder
```

> **Warning**
>
> Files deleted with `rm` do not go to a recycle bin. Double-check before pressing Enter.

---

# Viewing file contents

Display a small text file:

```bash
cat file.txt
```

Read large files one page at a time:

```bash
less file.txt
```

Exit `less` by pressing **q**.

---

# Searching

Find files by name:

```bash
find . -name "*.fastq.gz"
```

Search for text inside a file:

```bash
grep "gene" annotation.gff
```

These commands become especially useful when working with large sequencing projects.

---

# Command history

Every command you run is saved.

Display previous commands:

```bash
history
```

Repeat the previous command:

```bash
!!
```

You can also press the **Up Arrow** to cycle through recently used commands.

> **Tip**
>
> Using the arrow keys is often faster than typing the same command repeatedly.

---

# Getting help

If you're unsure how a command works, Linux provides built-in documentation.

```bash
man ls
```

or

```bash
ls --help
```

Most bioinformatics software also supports the `--help` option.

---

# Keyboard shortcuts

These shortcuts are worth learning early.

| Shortcut | Function |
|-----------|----------|
| Ctrl + C | Stop the current command |
| Ctrl + L | Clear the terminal |
| Tab | Auto-complete filenames |
| Up Arrow | Previous command |
| Ctrl + R | Search command history |
| Ctrl + A | Cursor to beginning of the line |
| Ctrl + R | Cursor to end of the line |

Learning just these shortcuts can save a surprising amount of time during everyday work.
