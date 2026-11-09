# Part 4: The HPC

Start in your `HPC_intro/exercise_data`.
● basic, ●● intermediate, ●●● advanced (optional)

Each exercise says if it needs HPC access. The others work on your laptop too.

## Moving data

### 4.1 Copy with rsync ●

Copy what is in `sample_B` to a new directory `backup_B` with `rsync -av`.

*Expected:* rsync lists the 3 files it copied

### 4.2 Copy again ●

Run the same command again.

*Expected:* nothing is copied: rsync only copies what changed

### 4.3 Check the copy ●●

Compute the checksums of both `R1` files: the original and the copy.

*Expected:* the same checksum twice

## screen (HPC access)

### 4.4 A screen session ●●

1. On the login node, start a `screen` session called `test`
2. Detach from it (`Ctrl+A`, then `d`), and list your sessions
3. Reattach, and close it with `exit`

*Expected:* `screen -ls` shows your session while you are detached;
`exit` prints `[screen is terminating]`

## Job scripts

### 4.5 Write a job script ●●

In `exercise_data`, create `job.sh` with `nano`: the `#SBATCH` lines from the `sbatch` slide,
then the command from your `count.sh`:

```bash
grep -c "^>" */assembly.fasta
```

### 4.6 Run your job script ●●

- **No HPC access**: run it on your laptop with `bash job.sh`.
  To the shell, `#SBATCH` lines are just comments
- **HPC access**: submit it with `sbatch job.sh`, follow it with `squeue -u <user>`,
  and read the log when it is done

*Expected:* the same 3 counts as `./count.sh`; on the HPC in `count_<jobid>.log`

## Resources

This one is on the slides too: think about it first, then we discuss it together.

### 4.7 What went wrong? ●●

Two jobs finished. `seff` shows:

```
Job A                                  Job B
State: COMPLETED                       State: OUT_OF_MEMORY
Cores per node: 16                     Cores per node: 4
CPU Efficiency: 6.25% of 03:50:24      CPU Efficiency: 91.45% of 00:45:00
Memory Efficiency: 3.75% of 32.00 GB   Memory Efficiency: 99.75% of 8.00 GB
```

What went wrong in each job, and what would you request next time?
