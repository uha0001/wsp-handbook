# Monitoring SLURM Jobs

Users should monitor submitted jobs to confirm that analyses are running
correctly and that requested resources are appropriate.

This is particularly important for long-running or resource-intensive jobs.

---

## View Your Jobs

```bash
squeue -u $USER
```

View all jobs:

```bash
squeue
```

A typical output may contain:

```text
JOBID  PARTITION  NAME      USER  ST  TIME  NODES
12345  compute    hisat2    user  R   1:32  1
```

---

## Common Job States

| State | Meaning |
|---|---|
| `PD` | Pending |
| `R` | Running |
| `CG` | Completing |
| `CD` | Completed |
| `F` | Failed |
| `CA` | Cancelled |
| `TO` | Timeout |

Additional states may appear depending on the final WSP configuration.

---

## Why Is My Job Pending?

A pending job is not necessarily a problem.

A job may wait because:

- requested CPUs are unavailable
- requested memory is unavailable
- resource limits have been reached
- other jobs have higher priority
- the requested resources cannot currently be allocated

Check the job:

```bash
squeue -j JOB_ID
```

Do not repeatedly cancel and resubmit waiting jobs unless you actually need to
change the job configuration.

---

## Cancel a Job

```bash
scancel JOB_ID
```

For example:

```bash
scancel 12345
```

---

## Inspect Output and Error Files

If the SLURM script contains:

```bash
#SBATCH --output=%x_%j.out
#SBATCH --error=%x_%j.err
```

the job will produce separate output and error files.

View output:

```bash
less myjob_12345.out
```

View errors:

```bash
less myjob_12345.err
```

---

## Follow Output While a Job Is Running

```bash
tail -f myjob_12345.out
```

Press:

```text
Ctrl+C
```

to stop following the file.

This does not cancel the SLURM job.

---

## Check Completed Jobs

If SLURM accounting is enabled:

```bash
sacct -j JOB_ID
```

More detailed information:

```bash
sacct -j JOB_ID \
    --format=JobID,JobName,State,Elapsed,AllocCPUS,MaxRSS,ExitCode
```

> **Note**
>
> The exact availability of `sacct` depends on the final WSP SLURM
> configuration.

---

## Check Memory Usage

If accounting is available:

```bash
sacct -j JOB_ID \
    --format=JobID,JobName,State,ReqMem,MaxRSS
```

`MaxRSS` can help estimate the maximum memory used by the job.

If a job repeatedly requests much more memory than it uses, future requests
should be reduced.

If a job runs out of memory, the request should be increased appropriately.

---

## Check Runtime

Compare requested wall time with actual elapsed time.

For example, if a job requests:

```bash
#SBATCH --time=2-00:00:00
```

but normally finishes in one hour, future requests can be reduced.

Reasonable time requests help improve scheduling for all users.

---

## CPU Usage

Requesting multiple CPUs only helps if the software can actually use them.

For example:

```bash
#SBATCH --cpus-per-task=8
```

should normally correspond to a program configured to use eight threads.

Check the software documentation before increasing CPU requests.

---

## Check Storage During Large Analyses

Check `/scratch`:

```bash
df -h /scratch
```

Check project size:

```bash
du -sh /scratch/USERNAME/PROJECT
```

Check subdirectories:

```bash
du -sh /scratch/USERNAME/PROJECT/*
```

See:

[Recommended Storage Practices](07_recommended_storage_practices.md)

---

## Good Monitoring Practice

For long-running jobs:

1. Confirm the job started.
2. Check the error file.
3. Confirm expected outputs are being produced.
4. Monitor storage use.
5. Check job status periodically.
6. Review resource use after completion.
7. Adjust future requests when necessary.
