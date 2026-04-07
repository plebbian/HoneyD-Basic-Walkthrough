# Honeyd PLC Honeypot Getting Started Guide

## Overview

This setup creates a simulated network environment using:

* Honeyd (network honeypot)
* Docker (containerized runtime)
* Docker Compose (orchestration)

---

## Architecture

* Fake PLC IP: `192.168.0.125`
* Protocol: Siemens S7 (port 102)

---

## Prerequisites

* **Linux host (recommended for full functionality)**
* Windows/MacOS will work but with simulated network (no real traffic)
* Docker installed
* Docker Compose installed
* Repository cloned

---

## Project Scripts

Optional helper scripts:

```bash
./scripts/START.sh
./scripts/RESET.sh
./scripts/logs.sh
./scripts/exec.sh
```

These are convenience wrappers around Docker Compose.

---

## Step 1: Start Honeyd

From the repository root, Linux:

```bash
docker compose --profile linux up --build
```
For Windows/MacOS:

```bash
docker compose --profile compat up --build
```
* Builds the Docker image
* Starts the Honeyd container
* Attaches to logs

---

## Step 2: Verify Honeyd is Running

Expected output:

```bash
[*] USING HONEYD BINARY: /usr/bin/honeyd
[*] STARTING HONEYD...
honeyd[1]: listening on lo: ip
```

---

## Step 3: Detach (Optional)

To leave the container running in the background:

```text
Press: d
```

---

## Step 4: Stop Honeyd

If running in the foreground:

```bash
CTRL + C
```

If running in the background:

```bash
docker compose down
```

---

## Logs and Debugging

View logs:

```bash
docker compose logs -f
```

Or:

```bash
./scripts/logs.sh
```

---

## Access the Container

To enter the running container:

```bash
docker compose exec honeyd bash
```

Or:

```bash
./scripts/exec.sh
```

---

## Notes

* This setup uses **host networking**, which requires Linux for full functionality.
* Windows and macOS may run the container, but network emulation may be limited.
* The container runs Honeyd with a predefined configuration located at:

```text
/opt/honeyd/honeyd.conf
```

---

## Troubleshooting

If something breaks:

1. Check logs:

   ```bash
   docker compose logs -f
   ```

2. Restart clean:

   ```bash
   docker compose down
   docker compose up --build
   ```

3. Ensure no conflicting containers:

   ```bash
   docker rm -f honeyd
   ```

---

## Summary

* Start: `docker compose up --build`
* Detach: press `d`
* Stop: `CTRL + C` or `docker compose down`
* Logs: `docker compose logs -f`
* Exec: `docker compose exec honeyd bash`
