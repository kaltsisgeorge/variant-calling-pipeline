#!/usr/bin/env bash
set -euo pipefail
mkdir -p data/reference data/reads
curl -sL "https://raw.githubusercontent.com/nf-core/test-datasets/modules/data/genomics/homo_sapiens/genome/genome.fasta" -o data/reference/genome.fasta
wgsim -N 20000 -1 100 -2 100 -r 0.002 -R 0.001 -e 0.005 \
  data/reference/genome.fasta \
  data/reads/sample_R1.fastq \
  data/reads/sample_R2.fastq \
  > data/reference/wgsim_truth.txt
gzip -f data/reads/sample_R1.fastq data/reads/sample_R2.fastq
