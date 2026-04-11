# Challenge 2: Identifying Honeypots

## Objective:
Analyze multiple IP addresses to identify which one is a honeypot by scanning for open ports, interacting with services, and recognizing inconsistencies that reveal simulated behavior.

### 1. Background
Low-interaction honeypots like ***Honeyd*** are designed to mimic real systems but only simulate limited behavior. While they can appear convincing at first glance, they often have subtle inconsistencies that can reveal they are not real machines.

Common characteristics that may give away a honeypot include:
- ***Unusual port combinations*** (e.g., many ports open that don’t logically belong together)
- ***Lack of deep interaction*** (services don’t behave fully like real ones)
- ***Identical responses across different ports***
- ***Operating system fingerprints that don’t match running services***

Attackers and security analysts use these clues to determine whether a target is a real system or a decoy.

### 2. Instructions:
You are given access to multiple IP addresses. One of them is a honeypot, and the others are real systems.

#### Step 1: Scan Each IP Address
Use a scanning tool to identify open ports and services:
<pre> nmap -sV (IP_ADDRESS) </pre>
Example:
<pre> nmap -sV 192.128.0.1
nmap -sV 192.128.0.2 </pre>

#### Step 2: Compare Results
For each IP, analyze:
* Open ports
* Service versions
* Operating system guesses

Look for inconsistencies such as:
* Services that don’t match the OS
* Too many open ports for a typical machine
* Strange or vague service version info

#### Step 3: Interact with Services
Try connecting to the services you discovered:

- HTTP:
<pre> curl http://(IP_ADDRESS) </pre>

- SSH: 
<pre> ssh user@(IP_ADDRESS) </pre>

- Netcat (generic interaction):
<pre> nc (IP_ADDRESS) (port) </pre>

#### Step 4: Identify Suspicious Behavior
Pay attention to:
* Responses that seem scripted or incomplete
* Services that don’t allow real interaction
* Identical or unrealistic outputs across different services

#### Step 5: Make Your Decision
Determine:
1. Which IP address is the honeypot
2. What specific detail(s) gave it away

### 3. Solution:


### 4. Actual Solution:
TBD