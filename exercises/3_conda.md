# Part 3: Package management with Conda

Start in your `HPC_intro/exercise_data`.
● basic, ●● intermediate, ●●● advanced (optional)

### 3.1 Install Miniforge ●

Install Miniforge as on the "Install Miniforge" slide.
When the installer asks to initialize conda, type `yes`.
On the HPC, when it asks where to install, type `/hpc/<group>/<user>/data/miniforge3`.

Then close your terminal and open a new one.

*Expected:* `conda --version` prints a version number

### 3.2 Set up the channels ●

Once:

```bash
conda config --add channels bioconda
conda config --add channels conda-forge
conda config --set channel_priority strict
```

### 3.3 Create an environment ●

Create an environment called `qc` with `seqkit` in it, and activate it.

*Expected:* your prompt starts with `(qc)`

### 3.4 Use the tool ●●

Run `seqkit stats` on all assemblies. Does `num_seqs` match your answers with `grep -c`?

```bash
seqkit stats */assembly.fasta
```

*Expected:* 5, 3 and 8 sequences

### 3.5 Leave the environment ●

Deactivate the environment, and list all your environments.

*Expected:* `base` and `qc`; `*` marks the active one

### 3.6 Share your environment ●●●

Export your environment to a file, then commit and push it to your fork.

```bash
conda env export -n qc --no-builds > environment.yml
```

*Expected:* `environment.yml` is in your fork on GitHub
