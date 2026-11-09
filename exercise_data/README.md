# Exercise data

Small example data for the workshop. The exercises themselves are in [../exercises](../exercises).

## Contents

```
exercise_data/
├── sample_A/
│   ├── assembly.fasta            # genome assembly (contigs)
│   ├── sample_A_R1.fastq.gz      # sequencing reads, forward
│   └── sample_A_R2.fastq.gz      # sequencing reads, reverse
├── sample_B/
│   └── ...
├── MD5.txt                       # checksums sent with the reads
└── sample_C/
    ├── ...
    └── old/
        └── assembly_v1.fasta     # an older assembly
```

In a FASTA file every sequence starts with a header line beginning with `>`,
followed by one or more lines of sequence.
