#!/bin/bash
# Solutions to the exercises.
# Run from inside exercise_data:  bash solutions.sh
# Interactive steps (nano, screen, ssh-keygen, git push, conda) are shown as comments.

## Moving around
pwd                         # .../HPC_intro/exercise_data
ls
ls -lh sample_B
cd sample_C/old
cd ../..
mkdir exercises
cd exercises
cd ..

## Working with files
head -n 3 sample_B/assembly.fasta
wc -l sample_B/assembly.fasta        # 101 lines, but only 3 sequences
# cd exercises
# nano notes.txt                     # Ctrl+O to save, Ctrl+X to quit
# cat notes.txt
# cp notes.txt backup.txt
# mv backup.txt old.txt
# rm old.txt
# cd ..

## screen and checksums
# screen -S test
# Ctrl+A D
# screen -ls
# screen -r test
# exit
md5sum -c MD5.txt                    # sample_B/sample_B_R2.fastq.gz FAILED
md5sum sample_B/sample_B_R2.fastq.gz
grep "sample_B_R2" MD5.txt           # the checksums differ

## find and grep
find . -name "*.fasta"
grep -c "^>" sample_A/assembly.fasta # 5
grep -i "plasmid" */assembly.fasta   # 6 headers, from 3 files
find . -name "*.fastq.gz" | wc -l    # 6

## Loops and scripts
for f in */assembly.fasta; do echo grep -c "^>" "$f"; done   # test with echo
for f in */assembly.fasta; do
    echo "$f"
    grep -c "^>" "$f"
done
# count.sh: "#!/bin/bash" on the first line, then the loop above
# chmod +x count.sh
# ./count.sh

## Git: save your work in your fork
# ls ~/.ssh                          # existing key? then skip ssh-keygen
# ssh-keygen -t ed25519 -C "you@example.com"
# cat ~/.ssh/id_ed25519.pub          # paste this on GitHub
# ssh -T git@github.com
# git remote set-url origin git@github.com:<your-username>/HPC_intro.git
# git remote -v
# git add exercises/notes.txt count.sh
# git commit -m "Add my exercise answers"
# git push

## Conda: install a tool
# conda config --add channels bioconda
# conda config --add channels conda-forge
# conda config --set channel_priority strict
# conda create -n qc seqkit
# conda activate qc
# seqkit stats */assembly.fasta      # num_seqs: A=5, B=3, C=8
# conda deactivate
# conda env list
# conda env export -n qc --no-builds > environment.yml

## HPC: job scripts and resources
# job.sh:
#   #!/bin/bash
#   #SBATCH --job-name=count
#   #SBATCH --output=count_%j.log
#   #SBATCH --cpus-per-task=1
#   #SBATCH --mem=1G
#   #SBATCH --time=00:05:00
#   (then the loop from count.sh)
# bash job.sh                        # no HPC access
# sbatch job.sh                      # HPC access
# squeue -u <your username>
# cat count_<jobid>.log
# seff output, job A: used 1 of 16 cores and 1.2 of 32 GB. Was the tool told to use
#   16 threads? If not, request -c 1 --mem=2G
# seff output, job B: OUT_OF_MEMORY. Request more memory, e.g. --mem=16G
# 20 genomes: test one first with -c 8 --mem=12G --time=01:00:00 and check seff.
#   All in one job: 20 x 30 min = 10 h, so --time=12:00:00. Or 20 separate jobs,
#   which can run at the same time.

# Clean up
rmdir exercises
