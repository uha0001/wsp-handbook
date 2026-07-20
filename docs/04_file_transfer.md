# File Transfer

Working on WSP means you'll regularly move files between your personal computer and the server. Depending on the size of your data and your preferred workflow, there are several ways to do this.

This guide introduces the most common transfer methods and explains when to use each one.

---

# Before transferring files

Before copying anything to WSP, decide where it belongs.

As a general guideline:

| Store in | Examples |
|----------|----------|
| `$HOME` | Scripts, software, documentation, small reference files |
| `scratch` | FASTQ files, BAM files, project folders, intermediate results |

If you're transferring a sequencing dataset or another large project, it should usually go to your scratch directory.

---

# Using SCP

`scp` (Secure Copy) transfers files over an encrypted SSH connection. It is available by default on Linux, macOS, and recent versions of Windows through PowerShell.

## Upload a file

```bash
scp file.txt username@141.48.90.77:/scratch/username/project/
```

## Upload a directory

```bash
scp -r project/ username@141.48.90.77:/scratch/username/
```

## Download a file

```bash
scp username@141.48.90.77:/scratch/username/project/results.csv .
```

The `.` represents your current directory on your local computer.

> **Tip**
>
> Press **Tab** to auto-complete long file paths instead of typing them manually.

---

# Using rsync

For large datasets or unreliable internet connections, `rsync` is often a better choice than `scp`.

```bash
rsync -avP raw_data/ username@141.48.90.77:/scratch/username/project/
```

Advantages of `rsync` include:

- resumes interrupted transfers
- displays transfer progress
- only copies changed files when run again

For projects containing many large sequencing files, `rsync` is usually the recommended option.

---

# Using MobaXterm

MobaXterm provides a graphical interface for transferring files.

Once connected to WSP, an SFTP file browser appears automatically.

Simply drag files between your computer and the remote directory.

> **Placeholder for screenshot**
>
> *Insert screenshot of the MobaXterm SFTP file browser.*

This is often the easiest option for users who are less comfortable with the command line.

---

# Using FileZilla

FileZilla is another graphical SFTP client.

To connect, enter:

- Host: `141.48.90.77`
- Protocol: **SFTP**
- Port: `22`
- Username: your WSP username
- Password: your WSP password

After connecting, you can drag and drop files between your local computer and WSP.

---

# Using a USB drive

If you are working directly at a WSP workstation, copying files from a USB drive can sometimes be the fastest option for large datasets.

Once the files are copied to the workstation, they can be moved to the appropriate directory on WSP.

---

# Downloading data directly to WSP

In many cases, it is faster to download public datasets directly onto WSP instead of downloading them to your personal computer first.

For example:

```
NCBI
   │
   ▼
 WSP
```

instead of:

```
NCBI
   │
   ▼
Laptop
   │
   ▼
 WSP
```

Many databases provide direct download links that can be used with tools such as `wget` or `curl`.

Downloading directly to WSP reduces transfer time and avoids storing large datasets on your local machine.

---

# Verifying your transfer

After transferring files, it's good practice to confirm that everything arrived correctly.

List the transferred files:

```bash
ls -lh
```

Check the size of a directory:

```bash
du -sh project/
```

If you transferred sequencing data, make sure the expected number of files is present before beginning your analysis.

---

# Choosing a transfer method

| Method | Best suited for |
|---------|-----------------|
| SCP | Small to medium transfers from the command line |
| rsync | Large datasets or unreliable internet connections |
| MobaXterm | Graphical drag-and-drop transfers on Windows |
| FileZilla | Graphical SFTP transfers across platforms |
| USB drive | Local transfers at a WSP workstation |

---

# Good practices

- Transfer large datasets directly to `scratch`.
- Verify that files arrived before deleting the originals.
- Avoid modifying raw data after transfer.
- Compress directories when transferring many small files.
- Use `rsync` instead of `scp` when transferring very large datasets or resuming interrupted transfers.
