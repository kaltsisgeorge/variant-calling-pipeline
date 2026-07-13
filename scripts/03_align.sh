#!/usr/bin/env bash
set -euo pipefail
REF=data/reference/genome.fasta
bwa index "$REF"
samtools faidx "$REF"
bwa mem -R "@RG\tID:sample1\tSM:sample1\tPL:ILLUMINA" "$REF" \
  results/sample_R1.trimmed.fastq.gz \
  results/sample_R2.trimmed.fastq.gz \
  | samtools sort -o results/sample.sorted.bam -
samtools index results/sample.sorted.bam
samtools flagstat results/sample.sorted.bam
