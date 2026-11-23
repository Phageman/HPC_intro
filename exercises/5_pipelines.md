# Part 5: Running pipelines

Start in your `HPC_intro/exercise_data`.
● basic, ●● intermediate, ●●● advanced (optional)

The example pipeline is in `HPC_intro/readqc`, laid out like the lab's real pipelines.
Its `README.md` has every command you need. Start there:

```bash
cd ../readqc
```

**No HPC access?** The pipeline is small enough for your laptop. Wherever an exercise says
`-j unlimited --workflow-profile workflow/profiles/hpc_slurm/`,
write `--workflow-profile workflow/profiles/local/` instead.
On a Mac with an Apple chip, use `snakemake_osx-arm64_conda_spec.txt` in 5.1.

### 5.1 Set up the pipeline ●

1. Create the Snakemake environment from the spec file, and activate it:

   ```bash
   conda create --name snakemake --file snakemake_linux-64_conda_spec.txt
   conda activate snakemake
   ```

2. Make the sample sheet: create `config/sample_table.csv` with `nano`.
   Write the line with the column names, then one line per sample, like this:

   ```
   sample_name,fastq_r1,fastq_r2
   sample_A,../exercise_data/sample_A/sample_A_R1.fastq.gz,../exercise_data/sample_A/sample_A_R2.fastq.gz
   ```

   Add a line for `sample_B` and one for `sample_C` the same way.
   Use `ls ../exercise_data/sample_B` to check the file names.

3. **HPC access**: fill in your Slurm account in `workflow/profiles/hpc_slurm/config.v8+.yaml`.
   It says `slurm_account: ""`. With `nano`, put your group's account between the quotes:
   `"dla_mm"` or `"umcu_mmb_nd"`.

*Expected:* `cat config/sample_table.csv` shows the column names and three lines:
`sample_A`, `sample_B` and `sample_C`, each with an R1 and an R2 file.
A typo in a path shows up in the dry run (5.2) as a missing input file.

### 5.2 Dry run ●

```bash
snakemake -j unlimited --workflow-profile workflow/profiles/hpc_slurm/ -n
```

*Expected:* a "Job stats" table with `fastp`, `seqkit_stats` once per sample, and one `merge_stats`.
Nothing ran yet: there is no `results/` directory.

### 5.3 Run it ●

Start a `screen` session (exercise 4.4), then run the same command without `-n`.
In a second terminal, watch the jobs with `squeue --me`.
On your laptop there is no `screen` or `squeue` needed: the steps run one after the other in your terminal.

*Expected:* the first time takes a few minutes, while Snakemake installs fastp and seqkit.
It ends with `(100%) done`. `cat results/stats_merged.tsv` shows 50 reads in every file.

### 5.4 Run it again ●●

1. Run the same command again
2. Delete one result, then do a dry run:

   ```bash
   rm results/sample_B/02_stats/sample_B_stats.tsv
   snakemake -j unlimited --workflow-profile workflow/profiles/hpc_slurm/ -n
   ```

*Expected:*

- after step 1: "Nothing to be done": everything is up to date
- after step 2: only `seqkit_stats` for `sample_B` and `merge_stats` would run, not `fastp`

### 5.5 Change a setting ●●●

With `nano`, change `min_length` in `config/config.yaml` from `50` to `101`.
Do a dry run first: what will run again, and why? Then run it and look at `results/stats_merged.tsv`.
Set it back to `50` afterwards.

*Expected:* every `fastp` job runs again ("params have changed"), and everything after it.
The reads are 100 bases long, so with a minimum of 101 every read is dropped: `num_seqs` is 0.
