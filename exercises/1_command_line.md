# Part 1: Command-line basics

Start in your `HPC_intro/exercise_data`.
● basic, ●● intermediate, ●●● advanced (optional)

## Moving around

### 1.1 Where am I? ●

Print your working directory.

*Expected:* a path that ends in `HPC_intro/exercise_data`

### 1.2 List and look ●

List what is here, then the details of `sample_B`, with file sizes.

*Expected:* 3 files in `sample_B`, with their sizes

### 1.3 Down and back up ●●

Go into `sample_C/old`, then back to `exercise_data` with one `cd`.

*Expected:* `pwd` ends in `exercise_data` again

### 1.4 Your own directory ●

Make a directory called `my_work`, go into it, and back up.

*Expected:* `ls` now also shows `my_work`

## Working with files

### 1.5 Look inside a file ●

Print the first 3 lines of `sample_B/assembly.fasta`.

*Expected:* a header line starting with `>`, then 2 lines of sequence

### 1.6 Count lines ●●

How many lines does `sample_B/assembly.fasta` have? Is that the number of sequences?

*Expected:* 101 lines, but not 101 sequences: every sequence spans many lines

### 1.7 Write notes ●

In `my_work`, create `notes.txt` with `nano`, write a few lines, save, then print it with `cat`.

*Expected:* the lines you wrote

### 1.8 Copy, rename, delete ●●

In `my_work`: copy `notes.txt` to `backup.txt`, rename `backup.txt` to `old.txt`,
then delete `old.txt`.

*Expected:* `ls` shows only `notes.txt` again

## Checksums

### 1.9 Check the reads ●

The sequencing company sent `MD5.txt` with the reads. Check all reads against it.

*Expected:* one file `FAILED`. Which one would you ask them to send again?

### 1.10 Compare by hand ●●

Compute the checksum of that file yourself, and compare it with its line in `MD5.txt`.

*Expected:* the two checksums differ

## find and grep

### 1.11 Find files ●

List all `.fasta` files in `exercise_data`, also those in subdirectories.

*Expected:* 4 files, one of them in `sample_C/old`

### 1.12 Count sequences ●●

How many sequences are in `sample_A/assembly.fasta`?
Every sequence starts with a header line beginning with `>`.

*Expected:* 5

### 1.13 Count files with a pipe ●●

Count all `.fastq.gz` files: send the output of `find` into `wc -l`.

*Expected:* 6

### 1.14 Plasmid headers ●●●

Which sequence headers contain the word "plasmid"? Upper and lower case should both match,
and only header lines count.

*Expected:* 6 headers, from 3 files

## Scripts

### 1.15 Your first script ●●

1. In `exercise_data`, create `count.sh` with `nano`. The first line is `#!/bin/bash`,
   the second line is a command that counts the sequences in every `assembly.fasta`:
   `grep -c "^>" */assembly.fasta`
2. Make it executable with `chmod +x`, and run it with `./count.sh`

*Expected:* 3 lines, one per assembly, each ending in the number of sequences (5, 3 and 8)

## Loops (optional)

### 1.16 A for loop ●●●

Write a `for` loop over every `*/assembly.fasta` that prints the file name,
and then the number of sequences in it. First put `echo` in front of `grep` to check it.

*Expected:* 3 file names, each followed by a number

### 1.17 A loop in a script ●●●

Put your loop in a new script, `count_loop.sh`, make it executable and run it.

*Expected:* the same output as your loop
