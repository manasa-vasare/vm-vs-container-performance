# Performance Analysis of Virtual Machines and Containers

## Abstract
This project evaluates and compares the performance characteristics of Virtual Machines (VMs) and Containers. By running a series of CPU, memory, disk I/O, and network benchmarks, we aim to quantify the overhead introduced by each virtualization technology.

## Objectives

## Research Questions

## Experimental Environment
The experiments were conducted on a VMware Virtual Machine with the following specifications:
- **CPU**: 4 vCPUs
- **Memory**: 8 GB RAM
- **Virtual Disk**: 60 GB
- **Guest OS**: Ubuntu 24.04 LTS (Kernel 7.0.0-34-generic)

## Hardware Configuration

## Software Configuration

## Architecture

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

## Disk I/O Experiment

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
