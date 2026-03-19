# Known Issues and Fixes

## 1. Config Not Found

```
[!] Honeyd config not found
```

### Cause:

Incorrect volume mount path

### Fix:

Ensure correct path:

```
/home/.../honeyd/Honeyd/honeyplc
```

---

## 2. Shared Library Error

```
error while loading shared libraries: libevent-2.1.so.6
```

### Cause:

Missing runtime dependencies in container

### Fix:

Add to Dockerfile:

```
libevent-2.1-6
libpcap0.8
libdumbnet1
zlib1g
```

---

## 3. PATH_HONEYDDATA Error

```
ERROR: Could not find path PATH_HONEYDDATA
```

### Cause:

Missing Honeyd data directory

### Fix:

Add volume:

```
/home/.../honeyd/Honeyd:/usr/share/honeyd:ro
```

---

## 4. Flex Scanner Error

```
input in flex scanner failed
```

### Cause:

Passing a directory instead of config file

### Fix:

Use correct file:

```
-f /home/.../honeyd/Honeyd/honeyplc
```

---

## 5. APT Repository Invalid

```
Release file is not valid yet
```

### Cause:

System clock out of sync

### Fix:

```
sudo timedatectl set-ntp true
```

---

## 6. Route Already Exists

```
SIOCADDRT: File exists
```

### Cause:

Route already added

### Fix:

Safe to ignore

---

## 7. Container Exits Immediately

### Cause:

Missing config or binary

### Fix:

Check mounts:

```
docker exec -it honeyd ls /opt/honeyd
```

---

## 8. PLCinject No Response

### Cause:

PLC server not running

### Fix:

Start Snap7 server:

```
sudo ./server 127.0.0.1
```

---
