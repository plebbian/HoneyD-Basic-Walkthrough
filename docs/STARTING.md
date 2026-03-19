# Honeyd PLC Honeypot Getting Started Guide

## Preview

This setup creates a simulated industrial control system environment using:

* Honeyd (network honeypot)
* Snap7 PLC server (real backend logic)
* Docker (deployment container)
* PLCinject (test client)

---

## Architecture

```
PLCinject (exploit tool) --> Honeyd (fake device) --> Snap7 Server (host responds)
```

* Fake PLC IP: `192.168.0.125`
* Protocol: Siemens S7 (port 102)

---

## Prerequisites

* Ubuntu 18.04 VM (honeyd already preconfigured)
* Docker + Docker Compose installed
* Preconfigured Honeyd source directory:

  ```
  /home/.../honeyd/Honeyd
  ```
* PLC server project:

  ```
  ~/honeyplc/
  ```

---

## Step 1: Fix System Time (if using VM)

```bash
sudo timedatectl set-ntp true
sudo systemctl restart systemd-timesyncd
timedatectl status
```

---

## Step 2: Build Docker Container

```bash
cd ~/.../HoneyD-Basic-Walkthrough
docker compose -f infra/compose/docker-compose.yml build --no-cache
```

---

## Step 3: Start PLC Backend (TERMINAL 1)

```bash
cd ~/honeyplc/honeyplc/snap7/examples/cpp/x86_64-linux
sudo ./server 127.0.0.1
```

Expected:

```
Server started
```

---

## Step 4: Start Honeyd (TERMINAL 2)

```bash
cd ~/.../HoneyD-Basic-Walkthrough
docker compose -f infra/compose/docker-compose.yml up
```

Expected:

```
Honeyd started
listening on lo
```

---

## Step 5: Test the System (TERMINAL 3)

```bash
cd ~/PLCinject
./plcinject -c 192.168.0.125 -d
```

Type:

```
y
```

Expected output:

```
DB21
DB103
DB3
```

---

## Step 6: Stop Services

Stop Honeyd:

```
CTRL + C
```

Stop PLC server:

```
CTRL + C
```

---

## Notes

* Honeyd runs inside Docker but uses host binary
* PLC server runs directly on host
* Loopback (`lo`) is used for communication
* Route is added automatically inside container

---
