# Exercise data: command line basics

Small example data for the exercises in the CLI/HPC workshop.

## Get the data

At the start of the workshop, open a terminal in your home directory and run:

```bash
git clone https://github.com/bayraktar1/HPC_intro.git
cd HPC_intro/exercise_data
```

After the Git section, make your own copy:

1. Log in on GitHub, or create an account
2. Go to <https://github.com/bayraktar1/HPC_intro> and click **Fork** to make your own copy
3. Your clone still points to the original repository. Check it with `git remote -v`.
   In the Git exercises you point it to your fork.

## Need HPC access?

Not everyone needs the HPC: the HPC part of the workshop works without access too.
If you will use it, request access **before the workshop**, because it takes time:

```bash
mkdir -p ~/.ssh
ssh-keygen -t ed25519 -C "HPC" -f ~/.ssh/id_ed25519_hpc
```

Choose a strong passphrase, then mail `~/.ssh/id_ed25519_hpc.pub` (the `.pub` file, never
the other one) to hpcsupport@umcutrecht.nl. Already have `~/.ssh/id_ed25519_hpc`? Then you
already have access: keep using that key.

## Contents

```
exercise_data/
├── sample_A/
│   ├── assembly.fasta            # genome assembly (contigs)
│   ├── sample_A_R1.fastq.gz      # sequencing reads, forward
│   └── sample_A_R2.fastq.gz      # sequencing reads, reverse
├── sample_B/
│   └── ...
├── MD5.txt                       # checksums sent with the reads
└── sample_C/
    ├── ...
    └── old/
        └── assembly_v1.fasta     # an older assembly
```

In a FASTA file every sequence starts with a header line beginning with `>`,
followed by one or more lines of sequence.

## Exercises

The same exercises as the "Try it" slides. Start in `~/HPC_intro/exercise_data`.

### Moving around

1. Where are you? Print your working directory
2. List what is here, then the details of `sample_B`
3. Go into `sample_C/old`, then back to `exercise_data` with one `cd`
4. Make a directory called `exercises`, go into it, and back up

### Working with files

1. Print the first 3 lines of `sample_B/assembly.fasta`
2. How many lines does that file have? Is that the number of sequences?
3. In `exercises`, create `notes.txt` with `nano`, write a few lines, then print it with `cat`
4. Copy `notes.txt` to `backup.txt`, rename `backup.txt` to `old.txt`, then delete `old.txt`

### screen and checksums

1. Start a `screen` session called `test`, detach from it, list your sessions, reattach, and close it with `exit`
2. The sequencing company sent `MD5.txt` with the reads. Check all reads against it: which file was corrupted?
3. Compute the checksum of that file yourself and compare it with its line in `MD5.txt`

### find and grep

1. List all `.fasta` files in `exercise_data`
2. How many sequences are in `sample_A/assembly.fasta`? Hint: every sequence header starts with `>`
3. Which sequence headers contain the word "plasmid"? Upper and lower case should both match
4. Count all `.fastq.gz` files: combine `find` with a pipe

### Loops and scripts

1. Write a `for` loop that prints the name and the number of sequences of every `assembly.fasta`. Test it with `echo` first
2. In `exercise_data`, put your loop in a script `count.sh`: start the file with the line `#!/bin/bash`
3. Make it executable with `chmod` and run it with `./count.sh`

### Git: save your work in your fork

1. Set up an SSH key for GitHub:
   - Already have a key? If `ls ~/.ssh` shows a `.pub` file, e.g. `id_ed25519.pub`, use that one and skip creating one. Not `id_ed25519_hpc.pub`: that one is only for the HPC
   - Create a key pair with `ssh-keygen -t ed25519 -C "<your email>"`: press Enter for the default location, then choose a passphrase
   - Print your public key with `cat ~/.ssh/id_ed25519.pub` and copy it
   - On GitHub: **Settings** → **SSH and GPG keys** → **New SSH key**, and paste it
   - Test the connection with `ssh -T git@github.com`
2. Point your clone to your fork, over SSH: `git remote set-url origin git@github.com:<your-username>/HPC_intro.git`, and check with `git remote -v`
3. `git add`, `git commit` and `git push` your `exercises/notes.txt` and `count.sh`

### Conda: install a tool

1. Set up the channels once:
   ```bash
   conda config --add channels bioconda
   conda config --add channels conda-forge
   conda config --set channel_priority strict
   ```
2. Create an environment called `qc` with `seqkit`, and activate it
3. In `exercise_data`, run `seqkit stats */assembly.fasta`. Does `num_seqs` match your answers with `grep -c`?
4. Deactivate the environment and list all your environments
5. Bonus: export your environment with `conda env export --no-builds > environment.yml` and push it to your fork

### HPC: job scripts and resources

These work without HPC access.

1. In `exercise_data`, create `job.sh`: the `#SBATCH` lines from the slides, then your loop from `count.sh`
   - No HPC access: run it with `bash job.sh`. To the shell, `#SBATCH` lines are just comments
   - HPC access: submit it with `sbatch job.sh`, follow it with `squeue -u <your username>`, and read `count_<jobid>.log` when it is done
2. Look at the two `seff` outputs on the "what went wrong?" slide. What went wrong, and what would you request next time?
3. You want to assemble 20 genomes. The tool uses 8 threads, about 10 GB of memory and 30 minutes per genome. What do you request?
