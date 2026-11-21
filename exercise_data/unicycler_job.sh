#!/bin/bash
#SBATCH --job-name=unicycler
#SBATCH --output=unicycler_%j.log
#SBATCH --error=unicycler_%j.err
#SBATCH --cpus-per-task=16
#SBATCH --mem=32G
#SBATCH --time=72:00:00

# Trim paired reads with fastp, then assemble them with Unicycler.
# Run with: sbatch unicycler_job.sh   (in exercise_data, next to the sample_* directories)
# fastp and unicycler must be available, e.g. in an active Conda environment.

threads="${SLURM_CPUS_PER_TASK:-1}"

# Go through the R1 fastq files in each sample directory
for r1_file in */*_R1*.fastq*; do
    # Get the name of the paired read
    r2_file="${r1_file/_R1/_R2}"

    # If the paired read exists, continue; otherwise skip the file
    if [[ -f "${r2_file}" ]]; then
        echo "Processing pair: R1: ${r1_file}, R2: ${r2_file}"
        base_name="${r1_file%%_R1*}"   # e.g. sample_A/sample_A: output goes next to the reads

        printf "Starting fastp for %s\n" "${base_name}"
        fastp \
            -i "${r1_file}" \
            -I "${r2_file}" \
            -o "${base_name}_trimmed_r1.fastq.gz" \
            -O "${base_name}_trimmed_r2.fastq.gz" \
            --unpaired1 "${base_name}_unpaired.fastq.gz" \
            --unpaired2 "${base_name}_unpaired.fastq.gz" \
            --json "${base_name}.json" \
            --html "${base_name}.html" \
            --thread "${threads}"
        printf "fastp for %s done!\n" "${base_name}"

        printf "Starting unicycler for %s\n" "${base_name}"
        unicycler \
            -1 "${base_name}_trimmed_r1.fastq.gz" \
            -2 "${base_name}_trimmed_r2.fastq.gz" \
            -s "${base_name}_unpaired.fastq.gz" \
            -o "${base_name}_unicycler_assembly" \
            --threads "${threads}"
        printf "unicycler for %s done!\n" "${base_name}"

    else
        echo "Pair for ${r1_file} is missing, skipping..."
    fi
done
