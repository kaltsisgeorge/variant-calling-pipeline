#!/usr/bin/env bash
set -euo pipefail
REF=data/reference/genome.fasta
bcftools mpileup -f "$REF" results/sample.sorted.bam | bcftools call -mv -Oz -o results/sample.raw.vcf.gz
bcftools index -t results/sample.raw.vcf.gz
bcftools view -i 'QUAL>=20' results/sample.raw.vcf.gz -Oz -o results/sample.filtered.vcf.gz
bcftools index -t results/sample.filtered.vcf.gz
