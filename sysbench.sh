#!/bin/bash

# Test CPU speed
sysbench cpu run --threads=$(nproc)

# Test mem speed
sysbench memory run --num-threads=$(nproc) --memory-total-size=100G --memory-block-size=1M
