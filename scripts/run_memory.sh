#!/bin/bash
OUTPUT_DIR="../results/raw/memory"
mkdir -p "$OUTPUT_DIR"

for i in {1..10}
do
    echo "Running memory test run $i"
    sysbench memory \
        --memory-block-size=1M \
        --memory-total-size=10G \
        --threads=4 \
        run > "$OUTPUT_DIR/run${i}.txt"
done
echo "Memory benchmark completed."
