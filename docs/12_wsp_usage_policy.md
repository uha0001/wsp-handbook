# WSP Usage Policy

> **Status: Operational guidelines**
>
> SLURM is installed and operational on WSP. The computational resource limits below reflect the configuration established during the WSP update.
>
> Storage management, backup procedures, and some administrative policies are still being developed. These sections will be updated as decisions are finalized.

---

## Purpose

WSP is a shared computational workstation used by multiple researchers.

The purpose of this policy is to:

- Provide fair access to computational resources.
- Prevent individual jobs from monopolizing WSP.
- Maintain sufficient storage for active research.
- Improve reproducibility.
- Reduce accidental disruption of other users.
- Establish clear expectations for computational analyses, software, and data management.

The goal is not to restrict legitimate research, but to ensure that WSP remains available and reliable for everyone.

---

# 1. Computationally Intensive Jobs

**Computationally intensive analyses should be submitted through SLURM.**

SLURM manages resource allocation and schedules jobs according to available CPUs, memory, and configured limits.

Examples of analyses that should normally use SLURM include:

- Read alignment and mapping.
- Genome assembly.
- Population-genomic analyses.
- Large RNA-seq analyses.
- Computationally intensive R or Python workflows.
- Analyses requiring multiple CPU cores.
- Memory-intensive analyses.
- Long-running computational pipelines.

Small commands, file inspection, script editing, and other lightweight tasks may be performed directly in interactive terminals.

Users should avoid running large analyses directly through SSH or desktop terminals.

> **Important:** SLURM limits apply to jobs submitted through SLURM. They do not automatically restrict computational processes launched outside the scheduler.

See [SLURM Basics](09_slurm_basics.md).

---

# 2. Resource Requests

Users should request only the resources necessary for their analyses.

This includes:

- CPU cores.
- Memory.
- Wall time.

Requesting substantially more resources than necessary reduces availability for other researchers.

For example, requesting 32 CPUs for a program that uses only four threads unnecessarily reserves extra resources.

Where supported, software thread counts should match the allocated CPUs.

```bash
#SBATCH --cpus-per-task=8
#SBATCH --mem=16G
#SBATCH --time=04:00:00
```

Users should monitor completed jobs and adjust future resource requests based on actual requirements.

---

# 3. WSP Resource Limits

WSP uses the `main` SLURM partition.

The `wsp_limits` Quality of Service (QOS) sets resource limits for shared computing.

| Resource | Configured limit |
|---|---|
| Maximum CPUs per job | 48 |
| Maximum memory per job | 250 GB |
| Maximum CPUs per user | 64 |
| Maximum memory per user | 300 GB |
| Maximum running jobs per user | 10 |
| Maximum submitted jobs per user | 100 |
| Maximum job duration | 30 days |
| Default job duration | 48 hours |

These limits are intended to prevent individual users from consuming an excessive proportion of WSP's available resources.

Multiple jobs may run simultaneously as long as the relevant limits and available resources permit.

Jobs that cannot start immediately will remain pending until they can be scheduled.

> **Administrative note:** These are the limits established during configuration. Administrators should verify the current QOS assignments and limits before treating this table as the definitive live configuration.

---

# 4. Maximum Job Duration

The configured maximum wall time for jobs under `wsp_limits` is **30 days**.

The default job duration is 48 hours when no other time limit is specified.

Users should request realistic runtimes rather than automatically selecting the maximum.

Examples:

```bash
#SBATCH --time=12:00:00
```

For a 12-hour job.

```bash
#SBATCH --time=7-00:00:00
```

For a seven-day job.

Jobs exceeding their wall-time allocation may be terminated by SLURM.

Discuss analyses requiring more than the configured maximum with WSP administrators in advance.

---

# 5. Large Jobs and Exceptions

Some analyses may legitimately require unusually large allocations.

Examples include:

- Large genome assemblies.
- Population-genomic analyses involving extensive datasets.
- Memory-intensive workflows.
- Analyses requiring exceptionally long runtimes.
- Large-scale computational pipelines.

Users should discuss these requirements with WSP administrators before exceeding normal limits.

Exceptions should evaluate exceptions based on available resources, other users' workloads, and the scientific requirements of the analysis.

Users should not attempt to bypass SLURM limits by running large analyses directly outside the scheduler.

---

# 6. Scratch Storage

`/scratch` is active computational working storage.

It is intended for:

- Active research projects.
- Large working datasets.
- Intermediate analysis files.
- Temporary computational outputs.
- Data required for ongoing analyses.

**Scratch is not intended to serve as permanent archival storage.**

Users remain responsible for managing their project data.

## Scratch expectations

Users should:

- Remove unnecessary intermediate files.
- Avoid duplicate copies of large datasets.
- Archive completed projects when appropriate.
- Monitor project directory sizes.
- Review inactive project directories.
- Keep important data backed up elsewhere.
- Avoid filling shared storage with temporary files that are no longer needed.

Check available scratch space:

```bash
df -h /scratch
```

Check the size of a project directory:

```bash
du -sh /scratch/USERNAME/PROJECT
```

Replace `USERNAME` and `PROJECT` with the appropriate directory names.

## Scratch utilization target

We have not yet finalized a formal utilization target.

We have discussed a possible overall storage threshold, but do not treat any percentage as established policy until it is approved and communicated.

Users should still avoid unnecessary storage use and report when scratch space is becoming critically low.

---

# 7. Old and Inactive Data

Review files belonging to completed or inactive projects periodically.

Where appropriate, transfer completed datasets to suitable archival or backup storage.

Users should not assume that scratch data will remain available indefinitely.

However, **automatic deletion or a fixed retention period has not been established as part of this policy**.

Any future cleanup procedure should include:

- Clear notification to affected users.
- Defined retention criteria.
- Reasonable time to retrieve or archive data.
- Consideration of ongoing research requirements.
- Appropriate administrative oversight.

Users should not delete or modify another researcher's project data without authorization.

---

# 8. External Hard Drives and USB Access

External drives may be used for transferring large datasets to or from WSP.

Where possible, keep at least one suitable high-speed USB connection accessible for data transfers.

Users should:

- Disconnect external drives safely after transfers.
- Avoid leaving drives connected unnecessarily.
- Ensure important data exists elsewhere before deleting originals.
- Coordinate unusually large transfers when necessary.
- Avoid treating external drives as permanent extensions of WSP storage without approval.

External storage devices should not interfere with other users' access to the workstation.

---

# 9. Software and Lmod Modules

WSP provides centrally installed scientific software, including programs managed through **Lmod environment modules**.

Users should check whether the required software is already available before installing another copy.

List available modules:

```bash
module avail
```

Search for software:

```bash
module spider samtools
```

Load a specific version:

```bash
module load samtools/1.25
```

Users should prefer centrally maintained software where appropriate.

Personal software installations are permitted when the required software or version is not available centrally.

Users must not modify shared software installations, system directories, or modulefiles without authorization.

## Software requests

Requests for new or updated software should include:

- Software name.
- Required version.
- Official website or repository.
- Scientific purpose.
- Project requiring the software.
- Expected users.
- Known dependencies, where relevant.

Software useful to multiple researchers should preferably be installed and documented centrally when practical.

See [Installing Software](04_installing_software.md).

---

# 10. Conda and User Environments

Personal Conda environments, Python virtual environments, and other user-specific software installations are permitted.

Users should:

- Use meaningful environment names.
- Avoid unnecessary duplicate installations.
- Remove environments that are no longer needed.
- Document important software versions.
- Keep permanent environments outside scratch storage.
- Avoid modifying shared environments without authorization.

For reproducibility, Conda environments can be exported:

```bash
conda env export > environment.yml
```

Users should be aware that activating Conda environments and loading Lmod modules can affect software paths and dependencies.

When possible, use a consistent software environment for each analysis.

---

# 11. Monitoring Jobs

Users are responsible for monitoring their submitted SLURM jobs.

This includes:

- Checking whether jobs start successfully.
- Reviewing output and error files.
- Monitoring resource consumption.
- Checking that CPU and memory requests are appropriate.
- Cancelling unnecessary jobs.
- Investigating unexpected failures.

View your jobs:

```bash
squeue -u $USER
```

View job accounting information:

```bash
sacct -u $USER --starttime today
```

Cancel a job:

```bash
scancel JOB_ID
```

See [Monitoring SLURM Jobs](10_monitoring_jobs.md).

---

# 12. Failed Jobs

Avoid repeatedly resubmitting a failing job without investigating the cause.

Before resubmitting:

- Inspect the error messages.
- Check SLURM job status and exit codes.
- Review memory and runtime requirements.
- Verify input files and paths.
- Confirm that the correct software environment is loaded.
- Check available scratch space.
- Correct the underlying problem where possible.

Users should not repeatedly submit jobs that are known to exceed the configured resource limits.

See [Troubleshooting WSP](11_troubleshooting.md).

---

# 13. Maintenance Windows

Major software updates, operating system maintenance, or SLURM configuration changes may require temporary WSP downtime.

We will notify users before planned maintenance whenever possible.

Before major maintenance, users should:

- Complete or safely stop active analyses where requested.
- Back up important research data.
- Disconnect external drives when appropriate.
- Document important software environments.
- Avoid starting long-running jobs that may overlap with the maintenance period.

Unplanned maintenance may occasionally be necessary to address urgent technical problems.

---

# 14. Backups and Data Responsibility

Users should not assume that all files stored on WSP are automatically protected against data loss.

Back up important research data to an appropriate independent location.

This is particularly important for:

- Raw sequencing data.
- Irreplaceable experimental datasets.
- Analysis scripts.
- Processed results.
- Reference files that cannot easily be reconstructed.
- Project documentation.

A separate WSP backup and recovery procedure should define which directories are backed up, how frequently backups occur, and how restoration requests are handled.

Until such a procedure is documented, users should not rely on WSP as the only location for important data.

---

# 15. Good Shared-Resource Practice

All WSP users are expected to:

- Submit computationally intensive analyses through SLURM.
- Request realistic CPU, memory, and runtime allocations.
- Respect configured resource limits.
- Monitor and manage their jobs.
- Avoid unnecessary duplication of large datasets.
- Remove abandoned temporary files.
- Use centrally installed software where practical.
- Document software versions and computational workflows.
- Communicate unusually large resource requirements.
- Report technical problems with sufficient information for troubleshooting.
- Avoid unauthorized changes to system-wide configurations.
- Respect other researchers' data and working directories.

WSP is a shared research resource. Responsible usage helps ensure that everyone can carry out their analyses efficiently.

---

# Current Policy Summary

| Policy | Current status |
|---|---|
| Computationally intensive jobs | Submit through SLURM |
| SLURM partition | `main` |
| Maximum CPUs per job | 48 |
| Maximum CPUs per user | 64 |
| Maximum memory per job | 250 GB |
| Maximum memory per user | 300 GB |
| Maximum running jobs per user | 10 |
| Maximum submitted jobs per user | 100 |
| Default job duration | 48 hours |
| Maximum job duration | 30 days |
| Software management | Lmod and user environments |
| Scratch utilization target | Not finalized |
| Inactive-file retention period | Not finalized |
| Large-job exception procedure | Contact WSP administrators; formal process pending |
| Automatic scratch deletion | No policy established |
| Backup and recovery procedure | To be documented |

These guidelines may be revised as WSP usage patterns, computational requirements, and administrative procedures evolve.
