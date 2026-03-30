# Honeyd PLC Honeypot Getting Started Guide

## Overview

This setup creates a simulated network environment using:

- Honeyd (network honeypot)
- Docker (containerized runtime)

---

## Architecture

- Fake PLC IP: `192.168.0.125`
- Protocol: Siemens S7 (port 102)

---

## Prerequisites

- Linux host
- Docker installed
- Repository cloned:

- Script available:
```bash
./scripts/START.sh
./scripts/RESET.sh
./scripts/logs.sh
./scripts/exec.sh
```

---

## Step 1: Start Honeyd

From the repository root:

```bash
./scripts/start.sh
```
- Builds image, removes any existing containers, starts the honeypot

## Step 2: Verify Honeyd is Running

Expected output:

```bash
[*] USING HONEYD BINARY: /usr/bin/honeyd
[*] STARTING HONEYD...
listening on lo
```

## Step 3: Stop Honeyd

To stop the honeypot:

```bash
CTRL + C
```

Or manually:

```bash
docker rm -f honeyd
```

## Extra info

The logs and exec scripts are for seeing what Honeyd is doing (observing) and going into the container (interacting).

Needed if:

- Something breaks
- Adding more files in