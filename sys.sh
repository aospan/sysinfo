#!/bin/bash

# Install required packages
sudo apt-get update
sudo apt-get install -y \
  curl dmidecode pciutils traceroute traceroute pciutils iproute2 sudo \
  sysbench

# cleanup
rm -rf /var/lib/apt/lists/*

# Collect sys info
/sbin/sysinfo.sh

# Run simple benchmarks
/sbin/sysbench.sh
