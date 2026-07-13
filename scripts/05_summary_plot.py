#!/usr/bin/env python3
import gzip
import matplotlib.pyplot as plt

VCF_PATH = "results/sample.filtered.vcf.gz"
OUT_PATH = "results/variant_summary.png"

quals, positions = [], []
with gzip.open(VCF_PATH, "rt") as f:
    for line in f:
        if line.startswith("#"):
            continue
        fields = line.strip().split("\t")
        positions.append(int(fields[1]))
        quals.append(float(fields[5]))

fig, axes = plt.subplots(1, 2, figsize=(11, 4))

axes[0].hist(quals, bins=20, color="#4C72B0", edgecolor="white")
axes[0].set_title("Variant call quality (QUAL) distribution")
axes[0].set_xlabel("QUAL score")
axes[0].set_ylabel("Number of variants")

axes[1].scatter(positions, quals, s=12, color="#DD8452")
axes[1].set_title("Variant positions across reference")
axes[1].set_xlabel("Position (bp)")
axes[1].set_ylabel("QUAL score")

fig.suptitle(f"{len(quals)} variants called — chr22 fragment (40 kb)")
fig.tight_layout()
fig.savefig(OUT_PATH, dpi=150)
print(f"Saved plot to {OUT_PATH}, {len(quals)} variants summarized")
