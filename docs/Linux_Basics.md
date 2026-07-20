# Linux Basics

This page covers the Linux commands you'll use most often on WSP.

---

## Where am I?

Show the current directory:

```bash
pwd
```

---

## List files

```bash
ls
```

Useful options:

```bash
ls -l
ls -lh
ls -a
```

---

## Change directories

```bash
cd folder_name
```

Go back one directory:

```bash
cd ..
```

Go to your home directory:

```bash
cd ~
```

---

## Create directories

```bash
mkdir project
```

Create multiple directories:

```bash
mkdir dir1 dir2 dir3
```

---

## Copy files

```bash
cp file.txt destination/
```

Copy directories:

```bash
cp -r project destination/
```

---

## Move or rename files

```bash
mv old_name new_name
```

Move a file:

```bash
mv file.txt folder/
```

---

## Delete files

Delete a file:

```bash
rm file.txt
```

Delete a directory:

```bash
rm -r folder
```

> Be careful. Deleted files cannot usually be recovered.

---

## View files

Display a file:

```bash
cat file.txt
```

Scroll through a large file:

```bash
less file.txt
```

---

## Search

Find a file:

```bash
find . -name "*.fastq"
```

Search inside a file:

```bash
grep "gene" file.txt
```

---

## Command History

View previous commands:

```bash
history
```

Run the previous command:

```bash
!!
```

---

## Get Help

Most commands include built-in documentation.

```bash
man command
```

or

```bash
command --help
```
