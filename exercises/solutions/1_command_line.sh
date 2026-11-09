#!/bin/bash
# Solutions, part 1: command-line basics.
# Run:  bash exercises/solutions/1_command_line.sh   (from anywhere)
# Steps you do by hand (nano) are shown as comments.
cd "$(dirname "$0")/../../exercise_data" || exit 1

## 1.1 Where am I?
pwd                                  # .../HPC_intro/exercise_data

## 1.2 List and look
ls
ls -lh sample_B

## 1.3 Down and back up
cd sample_C/old
cd ../..

## 1.4 Your own directory
mkdir -p my_work
cd my_work
cd ..

## 1.5 Look inside a file
head -n 3 sample_B/assembly.fasta

## 1.6 Count lines
wc -l sample_B/assembly.fasta        # 101 lines, but only 3 sequences

## 1.7 Write notes
# cd my_work
# nano notes.txt                     # Ctrl+O, Enter to save, Ctrl+X to quit
# cat notes.txt

## 1.8 Copy, rename, delete
# cp notes.txt backup.txt
# mv backup.txt old.txt
# rm old.txt
# cd ..

## 1.9 Check the reads
md5sum -c MD5.txt                    # sample_B/sample_B_R2.fastq.gz: FAILED

## 1.10 Compare by hand
md5sum sample_B/sample_B_R2.fastq.gz
grep "sample_B_R2" MD5.txt           # the checksums differ

## 1.11 Find files
find . -name "*.fasta"

## 1.12 Count sequences
grep -c "^>" sample_A/assembly.fasta # 5

## 1.13 Count files with a pipe
find . -name "*.fastq.gz" | wc -l    # 6

## 1.14 Plasmid headers
grep "^>" */assembly.fasta | grep -i "plasmid"   # 6 headers, from 3 files

## 1.15 Your first script
# nano count.sh, with these two lines:
#   #!/bin/bash
#   grep -c "^>" */assembly.fasta
# chmod +x count.sh
# ./count.sh

## 1.16 A for loop
for f in */assembly.fasta; do echo grep -c "^>" "$f"; done   # check first: echo in front
for f in */assembly.fasta; do
    echo "$f"
    grep -c "^>" "$f"
done

## 1.17 A loop in a script
# nano count_loop.sh: "#!/bin/bash" on the first line, then the loop above
# chmod +x count_loop.sh
# ./count_loop.sh

# Clean up what this script made
rmdir my_work 2>/dev/null
