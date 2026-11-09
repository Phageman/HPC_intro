#!/bin/bash
# Solutions, part 4: the HPC.
# Run:  bash exercises/solutions/4_hpc.sh   (from anywhere; runs the rsync part)
# Steps that need the HPC are shown as comments.
cd "$(dirname "$0")/../../exercise_data" || exit 1

## 4.1 Copy with rsync
rsync -av sample_B/ backup_B

## 4.2 Copy again
rsync -av sample_B/ backup_B         # nothing is copied

## 4.3 Check the copy
md5sum sample_B/sample_B_R1.fastq.gz backup_B/sample_B_R1.fastq.gz

rm -r backup_B                       # clean up

## 4.4 A screen session (on the login node)
# screen -S test
# Ctrl+A d                           # detach
# screen -ls
# screen -r test
# exit

## 4.5 Write a job script
# nano job.sh:
#   #!/bin/bash
#   #SBATCH --job-name=count
#   #SBATCH --output=count_%j.log
#   #SBATCH --cpus-per-task=1
#   #SBATCH --mem=1G
#   #SBATCH --time=00:05:00
#
#   grep -c "^>" */assembly.fasta

## 4.6 Run your job script
# bash job.sh                        # no HPC access
# sbatch job.sh                      # HPC access
# squeue -u <user>
# cat count_<jobid>.log

## 4.7 What went wrong?
# Job A: used 1 of 16 cores and 1.2 of 32 GB. Was the tool told to use 16 threads?
#   If not, request -c 1 --mem=2G
# Job B: OUT_OF_MEMORY, Slurm stopped it. Request more memory, e.g. --mem=16G
