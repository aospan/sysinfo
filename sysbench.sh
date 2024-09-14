#!/bin/bash

# Test CPU speed
echo "-- Benchmarking cpu"
sysbench cpu run --threads=$(nproc)

# Test mem speed
echo "-- Benchmarking mem"
sysbench memory run --num-threads=$(nproc) --memory-total-size=100G --memory-block-size=1M

# Test all disks sequential read speed
echo "-- Benchmarking disks"
for disk in $(lsblk -d -n -oNAME | grep -v loop);do
  DEV=/dev/$disk
  echo ${DEV}
  sudo dd if=${DEV} of=/dev/null bs=1M count=3000;
done
