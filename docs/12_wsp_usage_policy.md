# WSP Usage Policy

> **Status: Draft**
>
> This document describes proposed ground rules for using WSP as a shared
> computational resource.
>
> Specific numerical limits may change after SLURM installation and testing.

---

## Purpose

WSP is a shared computational resource.

The goal of this policy is to:

- provide fair access to computing resources
- prevent individual projects from monopolizing WSP
- maintain sufficient storage for active analyses
- improve reproducibility
- reduce accidental disruption of other users
- establish clear expectations for long-running analyses and storage

---

# 1. Computationally Intensive Jobs

Large or long-running analyses should be submitted through SLURM.

Users should avoid running computationally intensive analyses directly in
interactive SSH sessions.

Examples include:

- read alignment
- genome assembly
- population-genomic analyses
- large RNA-seq analyses
- large R or Python workflows
- jobs requiring many CPU cores
- jobs requiring substantial memory

---

# 2. Resource Requests

Users should request only the resources required by their analysis.

This includes:

- CPU cores
- memory
- wall time

Requesting substantially more resources than required reduces availability for
other WSP users.

WSP-specific maximum limits will be documented after SLURM configuration.

---

# 3. Fair Resource Allocation

No single user or project should continuously occupy the majority of WSP's
computational resources.

SLURM will be configured to distribute resources between users and projects in
a fair manner.

Possible mechanisms include:

- maximum CPU allocation per job
- maximum simultaneous CPU allocation per user
- memory limits
- fair-share scheduling
- maximum job duration
- queueing when resources are unavailable

Final limits are:

```text
TBD
```

---

# 4. Maximum Job Duration

Very long jobs can prevent other users from accessing WSP resources.

A maximum wall time will therefore be defined for normal jobs.

Proposed range:

```text
1–2 weeks maximum
```

The final limit will be determined after SLURM testing.

Jobs requiring longer runtimes should be discussed in advance.

---

# 5. Large Jobs and Exceptions

Some analyses may legitimately require more resources than the normal limits.

Examples may include:

- large genome assemblies
- unusually large population-genomic datasets
- memory-intensive analyses
- analyses with unusually long runtimes

Users should discuss these cases in advance so that appropriate resources can
be allocated without unnecessarily disrupting other projects.

---

# 6. Scratch Storage

`/scratch` is active working storage.

It is intended for:

- active computational projects
- large working datasets
- intermediate files
- temporary analysis outputs

It is not intended as permanent archival storage.

---

## Scratch Expectations

Users should:

- remove unnecessary intermediate files
- avoid unnecessary duplicate datasets
- archive completed projects
- monitor project size
- clean inactive project directories
- ensure important data are backed up elsewhere

Check available scratch space:

```bash
df -h /scratch
```

Check project size:

```bash
du -sh /scratch/USERNAME/PROJECT
```

---

## Scratch Usage Target

A target maximum total `/scratch` utilization may be introduced to preserve
sufficient working space for active analyses.

Proposed target:

```text
TBD
```

A strict 50% limit has been discussed but should only be implemented if it is
compatible with actual project requirements.

---

# 7. Old and Inactive Data

Files belonging to completed or inactive projects should be reviewed and
archived where appropriate.

Automated deletion should not be introduced without:

- clear notification
- defined retention rules
- sufficient time for users to retrieve or archive data

Possible future rules may include review of files that have not been modified
for a defined period.

Retention period:

```text
TBD
```

---

# 8. External Hard Drives and USB Access

External drives may be used for transferring large datasets to or from WSP.

At least one USB 3 connection should remain available for data transfer whenever
possible.

Users should disconnect external drives after transfers are complete unless the
drive is actively required.

External drives should not become permanent extensions of WSP storage without a
specific reason.

---

# 9. Software

Software may be provided through:

- system-wide installation
- environment modules
- Conda environments
- user-specific environments

Users should avoid modifying shared software installations unless they are
responsible for WSP administration.

---

## Software Requests

Requests for new or updated software should include:

- software name
- required version
- official website or repository
- purpose
- project using the software
- expected users
- dependencies, if known

Software required by multiple users should preferably be installed and
documented centrally where practical.

---

# 10. Conda and User Environments

Personal Conda environments are allowed when required.

Users should:

- keep environment names meaningful
- remove environments that are no longer needed
- document important environments used for research
- export environments when reproducibility is important

Example:

```bash
conda env export > environment.yml
```

---

# 11. Monitoring Jobs

Users are responsible for monitoring their submitted jobs.

This includes:

- checking whether jobs start correctly
- reviewing output and error files
- monitoring storage use
- checking whether resource requests are appropriate
- cancelling jobs that are no longer needed

See:

[Monitoring SLURM Jobs](10_monitoring_jobs.md)

---

# 12. Failed Jobs

Repeatedly resubmitting a failing job without investigating the cause should be
avoided.

Before resubmitting:

- inspect the error
- check resource usage
- check input files
- check software environment
- check available storage

See:

[Troubleshooting WSP](11_troubleshooting.md)

---

# 13. Maintenance Windows

Major system updates or maintenance may require temporary WSP downtime.

Users will be notified before planned maintenance whenever possible.

Before a major update:

- users should complete or stop active jobs
- important data should be backed up
- external drives should be disconnected
- required software and environments should be documented

---

# 14. Backups

Users should not assume that files stored on WSP are automatically protected
against every form of data loss.

Important research data should exist in an appropriate backup or archival
location.

The official WSP backup procedure will be documented separately.

---

# 15. Good Shared-Resource Practice

Users should:

- request only necessary resources
- avoid unnecessary duplicate data
- remove abandoned temporary files
- monitor long-running jobs
- communicate unusually large resource requirements
- report problems with sufficient technical information
- avoid system-wide changes without authorization

The goal is not to restrict legitimate analyses, but to ensure that WSP remains
usable for all researchers.

---

# Final Limits

The following values will be filled in after SLURM installation and testing:

| Policy | Limit |
|---|---|
| Maximum CPUs per job | TBD |
| Maximum CPUs per user | TBD |
| Maximum memory per job | TBD |
| Maximum normal job duration | TBD |
| Scratch utilization target | TBD |
| Inactive-file review period | TBD |
| Large-job exception procedure | TBD |
