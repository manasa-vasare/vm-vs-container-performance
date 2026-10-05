import pandas as pd
import matplotlib.pyplot as plt
import os

# Ensure figure directory exists
os.makedirs("results/figures", exist_ok=True)

# 1. Memory Plot
df_mem = pd.read_csv("results/processed/memory_results.csv")
mem_summary = df_mem.groupby("environment")["throughput_mib_s"].mean()

mem_summary.plot(kind="bar", title="Average Memory Throughput (Higher is Better)")
plt.ylabel("Throughput (MiB/s)")
plt.xlabel("Environment")
plt.tight_layout()
plt.savefig("results/figures/memory_performance.png", dpi=300)
plt.close()

# 2. Disk Plot
df_disk = pd.read_csv("results/processed/disk_results.csv")
disk_pivot = df_disk.pivot(index="test_type", columns="environment", values="throughput_mib_s")

disk_pivot.plot(kind="bar", title="Disk I/O Throughput Comparison (Higher is Better)")
plt.ylabel("Throughput (MiB/s)")
plt.xlabel("Test Type")
plt.xticks(rotation=45)
plt.tight_layout()
plt.savefig("results/figures/disk_performance.png", dpi=300)
plt.close()

print("Plots successfully generated in results/figures/")
