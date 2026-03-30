FROM ubuntu:18.04
ENV DEBIAN_FRONTEND=noninteractive

# Tools and libraries needed to configurate everything
RUN apt-get update && apt-get install -y \
    git \
    build-essential \
    autoconf \
    automake \
    libtool \
    pkg-config \
    bison \
    flex \
    ca-certificates \
    telnet \
    nmap \
    iproute2 \
    iputils-ping \
    net-tools \
    procps \
    tcpdump \
    libevent-dev \
    libpcap-dev \
    libpcre3-dev \
    libedit \
    libdumbnet-dev \
    zlib1g
    zlib1g-dev \
    && rm -rf /var/lib/apt/lists/*
WORKDIR /opt

RUN git clone https://github.com/DataSoft/Honeyd.git && \
    git clone https://github.com/sefcom/honeyplc.git

WORKDIR /opt/Honeyd
RUN ./autogen.sh && \
    ./configure && \
    make -j"$(nproc)" && \
    make install

RUN if [ -f /opt/honeyplc/snap7/build/bin/x86_64-linux/libsnap7.so-300 ]; then \
        cp /opt/honeyplc/snap7/build/bin/x86_64-linux/libsnap7.so-300 /usr/lib/libsnap7.so; \
    fi

WORKDIR /opt/honeyd

COPY entrypoint.sh /opt/honeyd/entrypoint.sh
COPY honeyd.conf /opt/honeyd/honeyd.conf

RUN chmod +x /opt/honeyd/entrypoint.sh

ENTRYPOINT ["/opt/honeyd/entrypoint.sh"]

