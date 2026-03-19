# Troubleshooting Guide

## Verify Honeyd is Running

```bash
docker ps
```

---

## Check Config Inside Container

```bash
docker exec -it honeyd cat /opt/honeyd/honeyd.conf
```

---

## Check Honeyd Data Files

```bash
docker exec -it honeyd ls /usr/share/honeyd
```

---

## Check Binary Exists

```bash
docker exec -it honeyd ls -l /usr/local/bin/honeyd-host
```

---

## Check Network Route

```bash
route
```

Expected:

```
192.168.0.0 via 127.0.0.1
```

---

## Check PLC Server

```bash
ps aux | grep server
```

---

## Test Connectivity

```bash
ping 192.168.0.125
```

---

## Debug Container (Advanced)

Run container in debug mode:

```yaml
command: ["sleep", "infinity"]
```

Then:

```bash
docker exec -it honeyd bash
```

---

## Check Dependencies

```bash
ldd /home/.../honeyd/Honeyd/honeyd
```

---

## Restart Everything Cleanly

```bash
docker compose down
docker rm -f honeyd
docker compose up --build --force-recreate
```

---

## Full Reset

```bash
docker system prune -a
```

---

## Still Not Working?

Check:

* Config path correct?
* Binary mounted?
* Libraries installed?
* PLC server running?
* Route exists?
* Interface set to `lo`?

---

## Debug Strategy

Always test in this order:

1. PLC server works alone
2. Honeyd works alone
3. Docker mounts correct
4. End-to-end test

---
