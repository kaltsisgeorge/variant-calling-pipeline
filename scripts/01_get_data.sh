#!/usr/bin/env bash
set -euo pipefail
mkdir -p data/reference data/reads

echo "Downloading a small reference (chr22 fragment, ~40kb)..."
curl --retry 3 --retry-delay 2 -sL "https://raw.githubusercontent.com/nf-core/test-datasets/modules/data/genomics/homo_sapiens/genome/genome.fasta" \
  -o data/reference/genome.fasta

echo "Simulating paired-end reads with wgsim (known SNPs + indels)..."
wgsim -N 20000 -1 100 -2 100 -r 0.002 -R 0.001 -e 0.005 \
  data/reference/genome.fasta \
  data/reads/sample_R1.fastq \
  data/reads/sample_R2.fastq \
  > data/reference/wgsim_truth.txt

gzip -f data/reads/sample_R1.fastq data/reads/sample_R2.fastq

echo "Done. Ground-truth variant positions saved to data/reference/wgsim_truth.txt"
