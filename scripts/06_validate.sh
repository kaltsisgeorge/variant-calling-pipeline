#!/usr/bin/env bash
# Compares called variants against the wgsim ground truth and reports accuracy.
set -euo pipefail

grep "^chr22" data/reference/wgsim_truth.txt | cut -f2 | sort > /tmp/truth_pos.txt
zcat results/sample.filtered.vcf.gz | grep -v "^#" | cut -f2 | sort > /tmp/called_pos.txt

TRUTH_COUNT=$(wc -l < /tmp/truth_pos.txt)
CALLED_COUNT=$(wc -l < /tmp/called_pos.txt)
MATCHED_COUNT=$(comm -12 /tmp/truth_pos.txt /tmp/called_pos.txt | wc -l)

echo "True variants:      $TRUTH_COUNT"
echo "Called variants:    $CALLED_COUNT"
echo "Correctly matched:  $MATCHED_COUNT"
echo "Recall:    $(echo "scale=1; $MATCHED_COUNT / $TRUTH_COUNT * 100" | bc)%"
echo "Precision: $(echo "scale=1; $MATCHED_COUNT / $CALLED_COUNT * 100" | bc)%"
