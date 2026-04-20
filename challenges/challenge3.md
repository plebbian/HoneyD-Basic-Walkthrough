# Challenge 3: Collecting Data Using A Honeypot

## Objective:
Analyze honeypot log data to determine what an attacker is attempting to do by examining connection attempts, targeted ports, and interaction patterns.

### 1. Background:
Honeypots like ***Honeyd*** are valuable because they collect detailed information about attacker behavior. Since all activity directed at a honeypot is considered suspicious, the logs provide insight into common attack methods.

Data collected by honeypots typically includes:
- Source IP addresses
- Targeted ports and services
- Connection timestamps
- Commands or payloads sent by attackers
- Frequency and pattern of requests

This data helps identify whether an attacker is:
- Scanning for open ports
- Attempting to exploit a service
- Trying to brute-force login credentials
- Probing for vulnerabilities

### 2. Instructions:
You are the owner of a honeypot system. An attacker has been interacting with it, and you have been given log data.

#### Step 1: View the Honeypot Logs
Use commands to inspect the log files:
```bash
cat honeypot.log
```
Or for larger files:
```bash
less honeypot.log
```

#### Step 2: Filter Relevant Activity
Search for specific patterns such as repeated IP addresses or ports:
```bash
grep "192.128.0" honeypot.log
```
```bash
grep "port" honeypot.log
```

#### Step 3: Identify Key Details
Look for:
* Repeated connection attempts from the same IP
* Targeted ports (e.g., 22 for SSH, 80 for HTTP)
* Any commands or unusual payloads

#### Step 4: Analyze Attacker Behavior
Based on the logs, determine:
* What service the attacker is targeting
* What type of attack is being attempted

Examples:
- Many attempts on port 22 -> possible SSH brute-force
- Requests to web pages with unusual input -> possible web exploitation
- Sequential port access -> port scanning

### 3. Solution:
To solve this challenge, the student must:
1. Examine the honeypot logs
2. Identify patterns in the attacker’s activity
3. Correlate ports and actions with known attack types
4. Draw a conclusion about the attacker’s goal

## 4. Actual Solution:
TBD
