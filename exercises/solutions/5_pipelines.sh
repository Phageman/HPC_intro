#!/bin/bash
# Solutions, part 5: running pipelines.
# Everything here runs the pipeline, so it is shown as comments:
# type the commands yourself, starting in your HPC_intro/exercise_data.

## 5.1 Set up the pipeline
# cd ../readqc
# conda create --name snakemake --file snakemake_linux-64_conda_spec.txt
# conda activate snakemake
# nano config/sample_table.csv       # write these four lines:
#   sample_name,fastq_r1,fastq_r2
#   sample_A,../exercise_data/sample_A/sample_A_R1.fastq.gz,../exercise_data/sample_A/sample_A_R2.fastq.gz
#   sample_B,../exercise_data/sample_B/sample_B_R1.fastq.gz,../exercise_data/sample_B/sample_B_R2.fastq.gz
#   sample_C,../exercise_data/sample_C/sample_C_R1.fastq.gz,../exercise_data/sample_C/sample_C_R2.fastq.gz
# cat config/sample_table.csv

## 5.2 Dry run
# snakemake -j unlimited --workflow-profile workflow/profiles/hpc_slurm/ -n
# snakemake --workflow-profile workflow/profiles/local/ -n             # laptop

## 5.3 Run it
# screen -S pipeline
# snakemake -j unlimited --workflow-profile workflow/profiles/hpc_slurm/
# squeue --me                        # in a second terminal
# cat results/stats_merged.tsv

## 5.4 Run it again
# snakemake -j unlimited --workflow-profile workflow/profiles/hpc_slurm/      # Nothing to be done
# rm results/sample_B/02_stats/sample_B_stats.tsv
# snakemake -j unlimited --workflow-profile workflow/profiles/hpc_slurm/ -n   # seqkit_stats (sample_B) + merge_stats

## 5.5 Change a setting
# nano config/config.yaml            # min_length: 101
# snakemake -j unlimited --workflow-profile workflow/profiles/hpc_slurm/ -n   # all fastp jobs: params have changed
# snakemake -j unlimited --workflow-profile workflow/profiles/hpc_slurm/
# cut -f1,4 results/stats_merged.tsv # num_seqs: 0 everywhere
# nano config/config.yaml            # back to min_length: 50
