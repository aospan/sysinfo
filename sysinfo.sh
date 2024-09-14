#!/bin/bash

function run_cmd {
  local CMD=$*

  echo -- Running ${CMD}
  ${CMD}
  echo -- Done ${CMD}
}

# Cloud instance info
CURL_ARGS="--connect-timeout 2"
echo AWS metadata:
TOKEN=`curl -X PUT "http://169.254.169.254/latest/api/token" -H "X-aws-ec2-metadata-token-ttl-seconds: 21600"`
run_cmd curl -H "X-aws-ec2-metadata-token: $TOKEN" http://169.254.169.254/latest/meta-data/instance-type
run_cmd curl -H "X-aws-ec2-metadata-token: $TOKEN" http://169.254.169.254/latest/meta-data/hostname

echo Azure metadata:
run_cmd curl ${CURL_ARGS} -H Metadata:true "http://169.254.169.254/metadata/instance?api-version=2017-08-01"

echo Google metadata:
run_cmd curl -H "Metadata-Flavor:Google" ${CURL_ARGS} "http://169.254.169.254/computeMetadata/v1/instance/machine-type"
run_cmd curl -H "Metadata-Flavor:Google" ${CURL_ARGS} "http://169.254.169.254/computeMetadata/v1/instance/image"
run_cmd curl -H "Metadata-Flavor:Google" ${CURL_ARGS} "http://169.254.169.254/computeMetadata/v1/instance/description"
run_cmd curl -H "Metadata-Flavor:Google" ${CURL_ARGS} "http://169.254.169.254/computeMetadata/v1/instance/hostname"
run_cmd curl -H "Metadata-Flavor:Google" ${CURL_ARGS} "http://169.254.169.254/computeMetadata/v1/instance/zone"

# Basic system info
run_cmd cat /proc/cpuinfo
run_cmd lsmem
run_cmd cat /etc/os-release 
run_cmd uname -a
run_cmd lsblk
run_cmd mount
run_cmd ps -A

# Networking
run_cmd ip addr
run_cmd ip neigh
run_cmd traceroute 8.8.8.8

# Hardware
run_cmd sudo dmidecode
run_cmd lspci
run_cmd lspci -v

# Logs
run_cmd sudo dmesg
