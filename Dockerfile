FROM ubuntu:22.04

RUN apt-get update && apt-get install -y sudo

COPY sys.sh /sbin
COPY sysinfo.sh /sbin
COPY sysbench.sh /sbin
RUN chmod +x /sbin/sys*.sh

# Collect build instance info
RUN sudo /sbin/sys.sh

# Collect runtime instance info
CMD ["/sbin/sys.sh"]
