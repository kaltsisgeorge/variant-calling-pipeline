#!/usr/bin/env bash
set -euo pipefail
fastqc data/reads/sample_R1.fastq.gz data/reads/sample_R2.fastq.gz -o results/
fastp \
  -i data/reads/sample_R1.fastq.gz -I data/reads/sample_R2.fastq.gz \
  -o results/sample_R1.trimmed.fastq.gz \
  -O results/sample_R2.trimmed.fastq.gz \
  -j results/fastp.json -h results/fastp.html
