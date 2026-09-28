# Performance Analysis of Virtual Machines and Containers

## Abstract
This project evaluates and compares the performance characteristics of Virtual Machines (VMs) and Containers. By running a series of CPU, memory, disk I/O, and network benchmarks, we aim to quantify the overhead introduced by each virtualization technology.

## Objectives
To experimentally compare the performance, resource utilization, application performance, and scalability of Virtual Machines (VMs) and Containers under identical workloads.

## Research Questions

## Experimental Environment
The experiments were conducted in two distinct environments running the same workloads to ensure a meaningful comparison.

## Hardware Configuration
**Virtual Machine (VMware Workstation)**
- **vCPU**: 4 virtual CPUs
- **Memory**: 8 GB RAM
- **Virtual Disk**: 60 GB
- **Network**: NAT

**Container (Docker)**
- **CPU Limit**: 4 CPUs
- **Memory Limit**: 8 GB
- **Storage**: Dedicated benchmark directory mounted into the container

## Software Configuration
- **Host OS**: Windows
- **Hypervisor**: VMware Workstation
- **Guest OS**: Ubuntu 24.04 LTS (Kernel 7.0.0-34-generic)
- **Container**: Docker (Base Image: ubuntu:24.04)
- **Programming / Analysis**: Python, Pandas, Matplotlib
- **Benchmarking Tools**: Sysbench (CPU & Memory), fio (Disk I/O), iperf3 (Network)
- **Application**: FastAPI, Uvicorn

## Architecture
```text
         PERFORMANCE ANALYSIS
                  │
      ┌───────────┴───────────┐
      │                       │
   VIRTUAL                CONTAINER
   MACHINE                 Docker
      │                       │
      └───────────┬───────────┘
                  │
            SAME WORKLOADS
                  │
      ┌───────────┼───────────┐
      ▼           ▼           ▼
     CPU        Memory  Disk / Network
                  │
                  ▼
          APPLICATION TEST
                  │
                  ▼
            FINAL ANALYSIS
```

## Methodology

## CPU Experiment
We utilized `sysbench` to measure CPU performance by calculating primes up to 20,000. Tests were executed with 1, 2, 4, and 8 threads. 

**Events Per Second (Higher is Better)**

| Threads | VM | Container |
|---------|-----------|----------------|
| 1       | 298.00    | 268.71         |
| 2       | 600.00    | 534.42         |
| 4       | 1027.19   | 787.52         |
| 8       | 1029.26   | 919.70         |

*Analysis*: In this specific configuration, the VM environment consistently outperformed the container environment in raw CPU throughput. Both environments scaled well up to 4 threads, at which point performance plateaued because the host VM is limited to 4 vCPUs.

Scripts are provided to process the raw output and generate visualizations:
- `scripts/analyze_results.py`: Computes average CPU performance across environments.
- `scripts/generate_plots.py`: Generates line charts comparing scalability (Threads vs Events per Second).
Plots are output to `results/figures/`.

## Memory Experiment
We utilized `sysbench` to measure memory performance by transferring a total of 10G using 1M block sizes. The test was run 10 times for both environments to compute a reliable average.

**Benchmark command:**
```bash
sysbench memory \
  --memory-block-size=1M \
  --memory-total-size=10G \
  --threads=4 \
  run
```

**Memory Throughput (MiB/s)**

| Run | VM | Container |
|-----|-----------|-----------|
| 1 | 24339.39 | 14483.00 |
| 2 | 25654.44 | 16959.34 |
| 3 | 24953.24 | 15297.17 |
| 4 | 25861.86 | 16355.80 |
| 5 | 26523.01 | 16627.22 |
| 6 | 24754.42 | 15460.75 |
| 7 | 24602.94 | 16431.35 |
| 8 | 23799.61 | 16186.24 |
| 9 | 25512.58 | 16509.75 |
| 10 | 25389.45 | 16214.04 |
| **Average** | **25139.094** | **16052.47** |

*Analysis*: The VM achieved an average memory throughput of 25139.094 MiB/s, while the Container averaged 16052.47 MiB/s. In this test, the Container's memory throughput was approximately 36.15% lower than that of the VM.

## Disk I/O Experiment
We utilized `fio` to measure storage performance by testing sequential and random read/write workloads against a 2G test file. This tests the overhead introduced by virtualization and container storage layers under different access patterns.

**Disk Throughput**

| Test | VM | Container |
|------|----|-----------|
| Sequential Write | 99.0 MiB/s | 84.8 MiB/s |
| Sequential Read | 191 MiB/s | 921 MiB/s |
| Random Read | 3406 KiB/s | 13.7 MiB/s |
| Random Write | 3645 KiB/s | 13.3 MiB/s |

*Analysis*: The VM performed slightly better than the Container in the Sequential Write test (99.0 MiB/s vs 84.8 MiB/s). However, the Container significantly outperformed the VM across all other workloads, achieving over four times the throughput in Sequential Read and substantially higher performance in both Random Read and Random Write operations (which were measured in MiB/s for the Container compared to KiB/s for the VM).

## Network Experiment

## Application Experiment
The project also includes a FastAPI application (`api/main.py`) which exposes `/compute`, `/memory`, and `/health` endpoints to test real-world application performance in both environments.

## Startup-Time Experiment

## Scalability Experiment

## Results

## Statistical Analysis

## VM vs Container Comparison

## Discussion

## Limitations

## Conclusion

## Future Work

## Reproduction Instructions
