# Getting Started

This guide covers the initial setup required before using WSP.

## Prerequisites

Before logging in, you should have:

- A WSP username
- A temporary password
- Network access
  - **On campus:** University network (Ethernet or Wi-Fi)
  - **Off campus:** Direct SSH access may work. If not, connect through the university VPN once your university account is active.
- An SSH client

### Supported SSH Clients

#### Windows PowerShell / Windows Terminal (Recommended)

Windows includes an OpenSSH client by default.

Connect to WSP using:

```bash
ssh -X <username>@141.48.90.77
```

Example:

```bash
ssh -X Ulku@141.48.90.77
```

When prompted, enter your password.

---

#### MobaXterm

MobaXterm is a graphical SSH client for Windows that provides:

- SSH terminal
- Built-in SFTP file browser
- Saved SSH sessions
- X11 forwarding

It is useful for users who frequently transfer files between their computer and WSP.

---

#### Linux / macOS

Open a terminal and connect using:

```bash
ssh -X <username>@141.48.90.77
```

---

## First Login

After logging in, verify that your session is working correctly.

Run:

```bash
whoami
pwd
ls
date
```

---

## Change Your Password

After your first login, change your temporary password.

```bash
passwd
```

Follow the prompts to choose a new password.

---

## File Organization

WSP uses two primary storage locations.

### Home Directory (`$HOME`)

Store:

- Scripts
- Programs
- Configuration files
- Important results
- Small reference datasets

The home directory is backed up periodically but has limited storage.

### Scratch Directory (`scratch`)

Store:

- Raw sequencing data
- Large datasets
- Intermediate files
- Temporary analysis results

Scratch is intended for high-capacity storage but is **not backed up**.

> **Note:** At the time of writing, there is no standardized project directory structure or naming convention across the lab. Organize your projects consistently within your own workspace.

---

## Good Practices

- Keep scripts and results organized.
- Use descriptive filenames.
- Store large files in `scratch`.
- Store code and important results in `$HOME`.
- Avoid modifying shared directories unless instructed.
- Be considerate of shared computing resources.

---

## Next Steps

After your first login:

- Learn the WSP directory structure.
- Read the Linux Basics guide.
- Learn how to transfer files.
- Learn how to use `screen` for long-running jobs.
- Learn basic resource management (`htop`, `nice`).
