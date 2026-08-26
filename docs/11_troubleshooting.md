# Troubleshooting WSP

Computational analyses sometimes fail.

Before asking for help, collect enough information for someone else to
understand the problem.

A message such as:

> WSP does not work.

does not provide enough information to diagnose the issue.

---

## Information to Include

When reporting a problem, provide:

1. What you were trying to do
2. The exact command or SLURM script used
3. The complete error message
4. Your working directory
5. Software name and version
6. Conda environment or module, if applicable
7. SLURM job ID, if applicable
8. Relevant `.out` and `.err` files
9. Whether the problem occurred previously
10. Any changes made immediately before the problem appeared

---

## Check Your Current Directory

```bash
pwd
```

List files:

```bash
ls -lh
```

---

## Check Whether a File Exists

```bash
ls -lh FILE
```

For example:

```bash
ls -lh sample_R1.fastq.gz
```

If a program reports that a file cannot be found, check:

- filename
- capitalization
- directory
- file extension
- relative versus absolute path

Linux filenames are case-sensitive.

For example:

```text
Sample.fastq.gz
```

and:

```text
sample.fastq.gz
```

are different files.

---

## Check Which Program Is Being Used

```bash
which PROGRAM
```

For example:

```bash
which samtools
```

This is particularly useful when multiple versions exist.

---

## Check Software Version

Examples:

```bash
samtools --version
```

```bash
hisat2 --version
```

```bash
R --version
```

```bash
python3 --version
```

---

## Check the Active Conda Environment

```bash
conda info --envs
```

The active environment is normally marked with `*`.

You can also run:

```bash
echo $CONDA_DEFAULT_ENV
```

See:

[Conda and Environments](05_conda_and_environments.md)

---

## Check Storage

```bash
df -h
```

Check scratch specifically:

```bash
df -h /scratch
```

A full filesystem can cause analyses to fail even when the software itself is
working correctly.

---

## Check Project Size

```bash
du -sh PROJECT_DIRECTORY
```

For example:

```bash
du -sh /scratch/username/project
```

Check subdirectories:

```bash
du -sh /scratch/username/project/*
```

---

## Check SLURM Jobs

```bash
squeue -u $USER
```

For a particular job:

```bash
squeue -j JOB_ID
```

If accounting is enabled:

```bash
sacct -j JOB_ID
```

See:

[Monitoring SLURM Jobs](10_monitoring_jobs.md)

---

## Read Output and Error Files

```bash
less myjob_12345.out
```

```bash
less myjob_12345.err
```

Do not report only the final error line if more context is available.

The lines immediately before the final error often explain what actually went
wrong.

---

## Check Whether a Job Ran Out of Memory

If accounting is available:

```bash
sacct -j JOB_ID \
    --format=JobID,JobName,State,ReqMem,MaxRSS,ExitCode
```

If memory was insufficient, increase the request appropriately.

Do not simply request all available WSP memory unless the analysis genuinely
needs it.

---

## Check Whether a Job Timed Out

If accounting is available:

```bash
sacct -j JOB_ID
```

A job that reaches its wall-time limit may appear with a timeout state.

Increase the requested time only as much as reasonably necessary.

---

## Check Permissions

```bash
ls -l FILE
```

For directories:

```bash
ls -ld DIRECTORY
```

Do not use:

```bash
chmod -R 777
```

as a general solution to permission problems.

If you do not understand the permission issue, ask before changing permissions
recursively.

---

## Check Running Processes

```bash
ps -u $USER
```

More detailed information:

```bash
ps -u $USER -o pid,etime,%cpu,%mem,cmd
```

Large analyses should normally be submitted through SLURM once SLURM is
available.

---

## Check Available Memory

```bash
free -h
```

Remember that WSP is shared and available memory changes as jobs start and stop.

---

## Check System Load

```bash
uptime
```

or:

```bash
top
```

Exit `top` with:

```text
q
```

High load does not necessarily mean WSP is malfunctioning. Other users may be
running legitimate analyses.

---

## Before Rerunning a Failed Job

Before resubmitting:

1. Check the job status.
2. Read the output file.
3. Read the error file.
4. Check available storage.
5. Check the software environment.
6. Check input paths.
7. Check requested resources.
8. Correct the problem.
9. Then resubmit.

Repeatedly submitting the same failing job wastes shared resources.

---

## Example Help Request

Instead of:

> HISAT2 doesn't work.

Provide:

> I submitted a paired-end HISAT2 alignment as SLURM job 12345.
>
> Working directory:
>
> `/scratch/username/project`
>
> HISAT2 version:
>
> `2.x.x`
>
> Conda environment:
>
> `rnaseq`
>
> The job failed after approximately two minutes.
>
> The relevant error from `hisat2_12345.err` is:
>
> `[error message]`
>
> The SLURM script used was:
>
> `[script or relevant commands]`

---

## WSP-Wide Problems

If the issue appears to affect WSP itself rather than one analysis, include:

- approximate time the problem started
- whether SSH still works
- whether `/scratch` is accessible
- commands that fail
- exact error messages
- whether other users experience the same problem

Do not restart services or modify system configuration unless you are
responsible for WSP administration.

---

## Related Documentation

- [Getting Started](00_getting_started.md)
- [Resource Management](01_resource_management.md)
- [Linux Basics](02_linux_basics.md)
- [File Organization](03_file_organization.md)
- [File Transfer](04_file_transfer.md)
- [Conda and Environments](05_conda_and_environments.md)
- [Installing New Software](06_installing_new_software.md)
- [Recommended Storage Practices](07_recommended_storage_practices.md)
- [SLURM Basics](08_slurm_basics.md)
- [SLURM Job Examples](10_slurm_job_examples.md)
- [Monitoring SLURM Jobs](09_monitoring_jobs.md)
