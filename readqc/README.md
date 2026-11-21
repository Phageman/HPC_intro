# readqc: a small example pipeline

Trims paired Illumina reads with fastp and counts them with seqkit, in Snakemake.
Built for the workshop: small, fast, and laid out like the lab's real pipelines,
so what you learn here works the same way there.

```
sample sheet ──> fastp (trim) ──> seqkit stats ──> merged table
                 one job per sample                one job for all samples
```

# Installation

The pipeline is already in your clone of the workshop repository:

```bash
cd /hpc/<group>/<user>/data/HPC_intro/readqc
```

To run the pipeline, you need the following Conda environment (once):

```bash
conda create --name snakemake --file snakemake_linux-64_conda_spec.txt
conda activate snakemake
```

On a Mac with an Apple chip (M1 or newer), use the Mac spec file instead:

```bash
conda create --name snakemake --file snakemake_osx-arm64_conda_spec.txt
conda activate snakemake
```

Snakemake installs fastp and seqkit itself, with the exact versions pinned for your system in
`workflow/envs/qc.linux-64.pin.txt` or `workflow/envs/qc.osx-arm64.pin.txt`.


# Usage

Make a sample sheet of the exercise data: create `config/sample_table.csv` with `nano`,
with the column names and one line per sample (see the example below).

To perform a dry run, which shows what would run without running it:

```bash
snakemake -j unlimited --workflow-profile workflow/profiles/hpc_slurm/ --dryrun
```

Running the pipeline. Snakemake submits every step to Slurm as a separate job:

```bash
snakemake -j unlimited --workflow-profile workflow/profiles/hpc_slurm/
```

The pipeline is small, so you can also run it on your own computer
(Linux, WSL or Mac). Use the local profile instead of the HPC one:

```bash
snakemake --workflow-profile workflow/profiles/local/ --dryrun
snakemake --workflow-profile workflow/profiles/local/
```

It runs on 2 cores; change `cores:` in `workflow/profiles/local/config.v8+.yaml` for more.

To unlock the directory after cancelling the pipeline early:

```bash
snakemake -j unlimited --workflow-profile workflow/profiles/hpc_slurm/ --unlock
```

## Samplesheet example

`config/sample_table.csv`: comma-separated, paths relative to `readqc/` (or full paths).

```
sample_name,fastq_r1,fastq_r2
sample_A,../exercise_data/sample_A/sample_A_R1.fastq.gz,../exercise_data/sample_A/sample_A_R2.fastq.gz
sample_B,../exercise_data/sample_B/sample_B_R1.fastq.gz,../exercise_data/sample_B/sample_B_R2.fastq.gz
sample_C,../exercise_data/sample_C/sample_C_R1.fastq.gz,../exercise_data/sample_C/sample_C_R2.fastq.gz
```

## Config file

`config/config.yaml`:

```yaml
samplesheet: "config/sample_table.csv"

fastp:
  min_length: 50 # drop reads shorter than this after trimming
```

# Output

```
results/
├── stats_merged.tsv
└── sample_A
    ├── 01_trim
    │   ├── sample_A_fastp.html
    │   ├── sample_A_fastp.json
    │   ├── sample_A_trimmed_R1.fastq.gz
    │   └── sample_A_trimmed_R2.fastq.gz
    └── 02_stats
        └── sample_A_stats.tsv
logs/          # one log per step and sample: look here when a step fails
benchmarks/    # time and memory each fastp job used
```
