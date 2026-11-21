rule fastp:
    input:
        fwd=lookup(query="sample_name == '{sample}'", within=samples, cols="fastq_r1"),
        rev=lookup(query="sample_name == '{sample}'", within=samples, cols="fastq_r2"),
    output:
        fwd="results/{sample}/01_trim/{sample}_trimmed_R1.fastq.gz",
        rev="results/{sample}/01_trim/{sample}_trimmed_R2.fastq.gz",
        json="results/{sample}/01_trim/{sample}_fastp.json",
        html="results/{sample}/01_trim/{sample}_fastp.html",
    params:
        min_length=config["fastp"]["min_length"],
    conda:
        "../envs/qc.yaml"
    threads: 4
    log:
        "logs/fastp/{sample}.log",
    benchmark:
        "benchmarks/fastp/{sample}.benchmark"
    shell:
        """
        (
        fastp \
            --in1 {input.fwd} --in2 {input.rev} \
            --out1 {output.fwd} --out2 {output.rev} \
            --length_required {params.min_length} \
            --json {output.json} --html {output.html} \
            --thread {threads}
        ) >{log} 2>&1
        """


rule seqkit_stats:
    input:
        rules.fastp.output.fwd,
        rules.fastp.output.rev,
    output:
        "results/{sample}/02_stats/{sample}_stats.tsv",
    conda:
        "../envs/qc.yaml"
    log:
        "logs/seqkit_stats/{sample}.log",
    shell:
        "seqkit stats -a -T {input} > {output} 2> {log}"


rule merge_stats:
    input:
        collect("results/{sample}/02_stats/{sample}_stats.tsv", sample=SAMPLES),
    output:
        "results/stats_merged.tsv",
    threads: 1
    log:
        "logs/merge_stats/merge_stats.log",
    shell:
        """
        (
        awk 'NR==1 || FNR>1' {input} > {output}
        ) >{log} 2>&1
        """
