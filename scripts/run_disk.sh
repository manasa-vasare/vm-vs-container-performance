#!/bin/bash
OUTPUT_DIR="../results/raw/disk"
mkdir -p "$OUTPUT_DIR"

echo "Running sequential write test"
fio --name=seq-write \
    --filename=~/fio-test/testfile \
    --size=2G \
    --bs=1M \
    --rw=write \
    --direct=1 \
    --iodepth=16 \
    --runtime=30 \
    --time_based > "$OUTPUT_DIR/seq-write.txt"

echo "Running sequential read test"
fio --name=seq-read \
    --filename=~/fio-test/testfile \
    --size=2G \
    --bs=1M \
    --rw=read \
    --direct=1 \
    --iodepth=16 \
    --runtime=30 \
    --time_based > "$OUTPUT_DIR/seq-read.txt"

echo "Running random read test"
fio --name=random-read \
    --filename=~/fio-test/testfile \
    --size=2G \
    --bs=4k \
    --rw=randread \
    --direct=1 \
    --iodepth=16 \
    --runtime=30 \
    --time_based > "$OUTPUT_DIR/random-read.txt"

echo "Running random write test"
fio --name=random-write \
    --filename=~/fio-test/testfile \
    --size=2G \
    --bs=4k \
    --rw=randwrite \
    --direct=1 \
    --iodepth=16 \
    --runtime=30 \
    --time_based > "$OUTPUT_DIR/random-write.txt"

echo "Disk benchmark completed."
