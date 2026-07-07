# File Transfer

There are several ways to transfer files between your local computer and WSP. The best method depends on the size of the files and your personal preference.

---

## Using SCP

`scp` (Secure Copy) is the standard command-line tool for transferring files over SSH.

### Copy a file to WSP

```bash
scp file.txt username@141.48.90.77:/path/to/destination/
```

### Copy a directory

```bash
scp -r project/ username@141.48.90.77:/path/to/destination/
```

### Copy a file from WSP

```bash
scp username@141.48.90.77:/path/to/file.txt .
```

The `.` represents your current local directory.

---

## Using MobaXterm

MobaXterm includes a built-in SFTP browser.

After connecting to WSP, your remote files appear in the left panel and can be transferred using drag and drop.

This is often the easiest option for users who prefer a graphical interface.

---

## Using FileZilla

FileZilla can also be used to transfer files through SFTP.

You'll need:

- Server address
- Username
- Password
- Port 22

---

## Using a USB Drive

Large files can also be copied directly using a USB drive connected to the WSP workstation.

This may be useful when transferring large datasets locally.

---

## Choosing a Transfer Method

| Method | Best For |
|---------|----------|
| SCP | Everyday use and automation |
| MobaXterm | Simple graphical transfers |
| FileZilla | Large graphical transfers |
| USB | Local transfer of large datasets |

---

## Tips

- Verify that files have transferred successfully before deleting the originals.
- Keep raw data organized from the start.
- Consider compressing large folders before transferring them.
