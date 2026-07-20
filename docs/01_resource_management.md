# Resource Management

WSP is a shared server, which means multiple people may be using it at the same time. Being mindful of resource usage helps everyone work more efficiently.

## Check Resource Usage

If you're about to start a computationally intensive task, it's a good idea to see what the server is currently doing.

```bash
htop
```

`htop` provides a live overview of:

- CPU usage
- Memory usage
- Running processes

Press **F10** to exit.

---

## Lower Process Priority

If you're running a long analysis that isn't time-sensitive, consider using `nice`:

```bash
nice <command>
```

Example:

```bash
nice bwa-mem FWD.fq REV.fq reference.fa > mapped.sam
```

This tells Linux that your process can yield CPU time to higher-priority tasks if needed.

---

## Long Running Jobs

For analyses that may run for hours or days, use `screen`.

Start a new session:

```bash
screen -S my_project
```

Detach without stopping the process:

```
Ctrl + A, then D
```

View running sessions:

```bash
screen -ls
```

Reconnect to a session:

```bash
screen -r my_project
```

Using `screen` allows your analysis to continue even if your SSH connection is interrupted.

---

## Good Practices

- Check resource usage before starting large analyses.
- Use `nice` when appropriate.
- Run long analyses inside a `screen` session.
- Close programs that are no longer needed.
- If you're unsure whether a job is appropriate for WSP or the HPC, ask before running it.

---

## Key Takeaways

- WSP is a shared resource.
- Be considerate of other users.
- Monitor your jobs.
- Use `screen` for long-running analyses.
