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
    libedit-dev \
    libdumbnet-dev \
    zlib1g \
    zlib1g-dev \
    python \
    python3 \
    python3-pip \
    && rm -rf /var/lib/apt/lists/*

# Install Python dependencies for Flask GUI
RUN pip3 install --upgrade pip==20.3.4 && \
    pip3 install Flask==1.1.2 docker==4.4.4

WORKDIR /opt

# Clone the same projects from your VM history
RUN git clone https://github.com/DataSoft/Honeyd.git && \
    git clone https://github.com/sefcom/honeyplc.git

RUN find /opt/Honeyd -name xprobe2.conf || true

# Build and install Honeyd
WORKDIR /opt/Honeyd
RUN ./autogen.sh && \
    ./configure && \
    make -j"$(nproc)" && \
    make install

RUN if [ -f /opt/honeyplc/snap7/build/bin/x86_64-linux/libsnap7.so-300 ]; then \
        cp /opt/honeyplc/snap7/build/bin/x86_64-linux/libsnap7.so-300 /usr/lib/libsnap7.so; \
    fi

WORKDIR /opt/honeyd

COPY infra/docker/entrypoint.sh /opt/honeyd/entrypoint.sh
COPY infra/config/honeyd.conf /opt/honeyd/honeyd.conf

RUN chmod +x /opt/honeyd/entrypoint.sh

ENTRYPOINT ["/opt/honeyd/entrypoint.sh"]

