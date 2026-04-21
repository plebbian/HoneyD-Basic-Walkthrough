# --Solutions--

## Scenario 1 - Windows Reconnaissance
Use Nmap

```bash
nmap -Pn -sV -O 192.168.0.10
```

- Shows fake machine
- Ports respond
- OS fingerprinting works

---

## Scenario 2 - Linux SSH Bruting
Use Hydra

```bash
hydra -t 4 -l testuser -P wordlist.txt ssh://192.168.0.20
```

- Shows fake Linux host
- Honeyd proxies to real SSH backend
- authentication works
- logs trigger

---

## Scenario 3 - Web Server Enumeration
Use Curl

```bash
curl http://192.168.0.30
```

- Shows fake web server
- HTTP proxy backend works
- Web enumeration works