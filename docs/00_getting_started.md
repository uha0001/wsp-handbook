# Getting Started

This guide will help you connect to WSP for the first time, set up your account, and understand where to store your files. It is intended for new users with little or no previous experience using Linux or remote servers.

---

## Before You Begin

Before connecting, make sure you have:

- A WSP username
- A temporary password
- Network access
  - **On campus:** Connect through the university network (Ethernet or Wi-Fi).
  - **Off campus:** Direct SSH access usually works. If you cannot connect, try connecting to the university VPN first.
- An SSH client

> **Tip**
>
> If you're unsure whether you have network access, try opening the WSP IP address in your browser. If it doesn't respond, you may need to connect to the university network or VPN before SSH will work.

---

## Connecting to WSP

### Windows (Recommended)

The easiest way to connect to WSP from Windows is by using **PowerShell** or **Windows Terminal**. Both include an OpenSSH client by default, so you do not need to install any additional software.

1. Open **PowerShell** or **Windows Terminal**.
2. Run:

```bash
ssh -X <username>@141.48.90.77
```

For example:

```bash
ssh -X ulku@141.48.90.77
```

The first time you connect, Windows will ask whether you trust the server:

```text
The authenticity of host '141.48.90.77' can't be established.
Are you sure you want to continue connecting (yes/no/[fingerprint])?
```

Type:

```text
yes
```

and press **Enter**.

You will then be prompted for your password.

> **Note**
>
> Nothing will appear on the screen while you type your password. This is normal and is done for security reasons.

> **Tip**
>
> You do **not** need to type `ssh` from the WSP server itself. The `ssh` command is only used to connect **from your own computer** to WSP.

---

### Windows (MobaXterm)

MobaXterm is an alternative SSH client for Windows. While it is not required, some users prefer it because it includes a built-in graphical file browser (SFTP), saved SSH sessions, and X11 forwarding.

If you frequently transfer files between your computer and WSP, MobaXterm can be a convenient option.

---

### Linux and macOS

Open a terminal and connect using:

```bash
ssh -X <username>@141.48.90.77
```

The login process is the same as on Windows.
> **Tip**
>
> Once you've connected successfully a few times, consider creating an SSH configuration file so you can simply run:
>
> ```bash
> ssh wsp
> ```
>
> instead of typing the full server address every time.

---

## Your First Login

Once you're connected, verify that everything is working correctly.

Run:

```bash
whoami
pwd
ls
date
```

These commands confirm:

- your username (`whoami`)
- your current directory (`pwd`)
- the files in that directory (`ls`)
- the system date and time (`date`)

> **Tip**
>
> If you're ever unsure where you are while working on WSP, `pwd` is one of the most useful commands to remember.

---

## Change Your Password

If this is your first login, change your temporary password before doing anything else.

```bash
passwd
```

Follow the prompts to choose a new password.

> **Tip**
>
> Your new password won't be displayed while you type. If you make a mistake, simply press **Enter** and try again.

---

## Understanding Storage

WSP provides two main storage locations.

### Home Directory (`$HOME`)

Use your home directory for files you want to keep long-term, including:

- scripts
- software you install yourself
- configuration files
- important results
- small reference datasets

Your home directory is backed up regularly, but storage space is limited.

### Scratch Storage

Scratch is intended for large datasets and temporary analyses, such as:

- raw sequencing data
- FASTQ files
- BAM files
- intermediate analysis files
- temporary outputs

Scratch provides much more storage space but **is not backed up**.

> **Warning**
>
> Never keep the only copy of important data on scratch. Always maintain another copy of your raw data.

> **Note**
>
> There is currently no standard project directory structure across the lab. Choose a consistent organization that works for you and keep related files together.

---

## Good Habits

Developing good habits early will make projects much easier to manage later.

We recommend:

- keeping scripts separate from raw data
- using descriptive file and folder names
- storing large datasets on scratch
- keeping code and important results in your home directory
- avoiding changes to shared directories unless necessary
- cleaning up temporary files when they are no longer needed
- being considerate when using shared computing resources

> **Tip**
>
> It's much easier to stay organized from the beginning than to reorganize a project several months later.

---

## Where to Go Next

Once you've successfully logged in, continue with the following guides:

1. Linux Basics
2. File Organization
3. File Transfer
4. Using `screen` for long-running analyses
5. Resource Management

> **Recommended**
>
> If you're new to Linux, read the **Linux Basics** guide before attempting to install software or run large analyses. Understanding a few basic commands will save a lot of frustration later.
