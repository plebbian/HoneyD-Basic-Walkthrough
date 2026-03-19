FROM ubuntu:18.04

ENV DEBIAN_FRONTEND=noninteractive

# Minimal runtime tools + shared libraries required by the host Honeyd binary.
RUN apt-get update && apt-get install -y \
    iproute2 \
    iputils-ping \
    net-tools \
    procps \
    tcpdump \
    libevent-2.1-6 \
    libpcap0.8 \
    libdumbnet1 \
    zlib1g \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /opt/honeyd

COPY entrypoint.sh /opt/honeyd/entrypoint.sh
RUN chmod +x /opt/honeyd/entrypoint.sh

ENTRYPOINT ["/opt/honeyd/entrypoint.sh"]