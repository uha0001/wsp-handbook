# Getting Started

This page covers everything you need before you begin working on WSP, from connecting to the server for the first time to organizing your files.

## Before You Begin

To connect to WSP, you will need:

- A WSP username
- A temporary password
- Network access
  - **On campus:** Connect through the university network (Ethernet or Wi-Fi).
  - **Off campus:** You can usually connect directly via SSH. If that doesn't work, connect to the university VPN first.
- An SSH client

## Connecting to WSP

### Windows (PowerShell or Windows Terminal)

Modern versions of Windows include OpenSSH by default, so no additional software is required.

Open PowerShell or Windows Terminal and run:

```bash
ssh -X <username>@141.48.90.77
```

For example:

```bash
ssh -X ulku@141.48.90.77
```

The first time you connect, you may be asked whether you trust the server. Type `yes` and press Enter. You will then be prompted for your password. Nothing will appear on the screen while you type it, which is normal.

### Windows (MobaXterm)

If you prefer a graphical interface, MobaXterm is a good alternative. It combines an SSH terminal with a built-in file browser, making it convenient for transferring files between your computer and WSP.

### Linux and macOS

Open a terminal and connect using the same command:

```bash
ssh -X <username>@141.48.90.77
```

## Your First Login

Once you're connected, it's worth checking that everything is working as expected.

Run:

```bash
whoami
pwd
ls
date
```

These commands confirm your username, current working directory, available files, and the system date.

## Change Your Password

If this is your first login, change your temporary password before doing anything else.

```bash
passwd
```

Follow the prompts to choose a new password.

## Understanding Storage

WSP provides two main storage locations, each intended for different types of files.

### Home Directory (`$HOME`)

Your home directory should contain files you want to keep long-term, such as:

- scripts
- software you installed yourself
- configuration files
- important results
- small reference datasets

The home directory is backed up regularly, but available storage is limited.

### Scratch Storage

Scratch is designed for large files and temporary analyses. Typical examples include:

- raw sequencing data
- intermediate files
- alignment files
- temporary analysis outputs

Scratch offers much more storage space, but it is **not backed up**. Never store the only copy of important data there.

> **Note:** There is currently no standard directory structure used across the lab. Choose a consistent organization that works for you and keep related files together.

## Good Habits

A little organization goes a long way. We recommend:

- using descriptive file and folder names
- keeping scripts separate from raw data
- storing large datasets in scratch
- keeping code and important results in your home directory
- avoiding changes to shared directories unless necessary
- being considerate when using shared computing resources

## Where to Go Next

Once you've successfully logged in, the next guides to read are:

1. Linux Basics
2. File Organization
3. File Transfer
4. Using `screen` for long-running analyses
5. Resource Management
