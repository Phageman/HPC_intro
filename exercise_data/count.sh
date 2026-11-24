#!/bin/bash
for f in sample_B/*.fastq.gz; do 
	md5sum "$f"
done

