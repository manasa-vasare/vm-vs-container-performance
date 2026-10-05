#!/bin/bash
OUTPUT_DIR="../results/raw/network"
mkdir -p "$OUTPUT_DIR"

SERVER_IP=${1:-"127.0.0.1"}

echo "Running single stream network test against $SERVER_IP"
iperf3 -c $SERVER_IP -t 30 > "$OUTPUT_DIR/iperf3.txt"

echo "Running multi-stream (4) network test against $SERVER_IP"
iperf3 -c $SERVER_IP -t 30 -P 4 > "$OUTPUT_DIR/iperf3-p4.txt"

echo "Network benchmark completed."
