# WSP System Snapshot Before Upgrade

**Date collected:** July 2026  
**Purpose:** Baseline documentation before major system changes.

This document records the current WSP environment before any major system upgrade or infrastructure changes. The purpose is to preserve information about the operating system, software environment, and configuration so that changes can be evaluated and validated.

---

# Operating System

## OS Information

| Component | Information |
|---|---|
| Operating System | Ubuntu 16.04.7 LTS (Xenial Xerus) |
| Version ID | 16.04 |
| Codename | xenial |
| Architecture | x86_64 |
| Kernel | Linux 4.15.0-142-generic |

Command used:

```bash
cat /etc/os-release
uname -a
```

---

# Hardware

_To be completed._

Commands:

```bash
lscpu
free -h
df -h
```

Information to record:

- CPU model and number of cores
- Total RAM
- Swap space
- Storage devices and partitions

---

# Installed Software

## Bioinformatics Software

| Software | Version | Location | Status |
|---|---|---|---|
| FastQC | 0.11.5 | `/usr/local/bin/fastqc` | Working |
| MultiQC | 1.8 | `/usr/local/bin/multiqc` | Error |
| HISAT2 | 2.1.0 | `/usr/local/bin/hisat2` | Working |
| Samtools | 1.11 | `/usr/local/bin/samtools` | Working |
| Salmon | 0.9.1 | Unknown | Working |
| featureCounts | Not installed/found | - | Missing |
| STAR | Not installed/found | - | Missing |

---

## Programming Languages

| Software | Version |
|---|---|
| Python | 3.9.17 |
| R | 4.1.0 |
| GCC | 9.4.0 |
| G++ | 9.4.0 |

---

## Conda

| Component | Version |
|---|---|
| Conda | 23.5.2 |

Conda environments:

_To be documented._

Command:

```bash
conda env list
```

Important environments should be exported:

```bash
conda env export -n ENVIRONMENT_NAME > environment.yml
```

---

# Software Issues Identified

## MultiQC

Current version:

```
MultiQC 1.8
```

Issue:

```
pkg_resources.DistributionNotFound:
The 'multiqc==1.8' distribution was not found
```

Possible cause:

- Broken Python installation
- Missing package dependency
- Global installation pointing to missing environment

Suggested solution:

- Install MultiQC inside a controlled Conda environment.
- Document the installation method.

---

# Package Inventory

A list of installed system packages was generated:

```bash
apt list --installed > installed_packages.txt
```

This file should be preserved as part of the pre-upgrade snapshot.

---

# SSH Configuration

Current SSH configuration:

| Setting | Value |
|---|---|
| SSH Port | 22 |
| Protocol | SSH2 |
| Root login | Disabled (prohibit-password) |
| Public key authentication | Enabled |
| SFTP | Enabled |

Configuration file:

```
/etc/ssh/sshd_config
```

---

# Network Configuration

Current active interface:

```
eno2
```

Internal network information:

```
141.48.90.77
```

Other interfaces:

- eno1: inactive
- Docker bridge: present

Note:
Network details should remain in internal documentation and should not be published in a public repository.

---

# Configuration Files to Preserve

Before upgrades, important configuration files should be archived.

Suggested files:

```
/etc/ssh/sshd_config
/etc/fstab
```

Additional configuration files:

- Conda environment files
- Workflow configuration files
- Software configuration files

---

# Upgrade Preparation Checklist

Before major system changes:

- [ ] Record operating system version
- [ ] Record kernel version
- [ ] Record hardware configuration
- [ ] Record installed software versions
- [ ] Export Conda environments
- [ ] Save important configuration files
- [ ] Generate installed package list
- [ ] Confirm backup availability
- [ ] Inform users of planned maintenance

---

# Post-Upgrade Validation

After changes:

- [ ] Confirm user access
- [ ] Confirm storage accessibility
- [ ] Test important software
- [ ] Test Conda environments
- [ ] Test common workflows
- [ ] Update documentation

---

# Additional Notes

The current system contains a mixture of system-installed and user-installed software. Any upgrade should include testing of existing workflows to avoid breaking dependencies.

Important areas requiring attention:

- MultiQC installation
- Missing commonly used bioinformatics tools
- Software version documentation
- Conda environment management
- Reproducible workflow setup
