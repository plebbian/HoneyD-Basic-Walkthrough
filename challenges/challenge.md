# Challenge 1: Interact with a HoneyPot

## Objective:
Interact with the low-interaction honeypot running at 192.128.0.1 by:    
1. Discovering open ports  
2. Connecting to those ports to observe how the honeypot responds

### 1. Background:
***Low-interaction honeypots*** are systems that pretend to be real computers or services, but they don’t actually run full programs. They mimic things like ***network stacks, open ports, and basic services*** so they look real in order to draw in attackers. Their main purpose is to attract and monitor malicious activity without putting real systems at risk. This means they can respond to scans and simple connection attempts, but they ***don’t allow deep interaction***. This makes them safer and easier to manage, but they also can’t capture very advanced attack behavior and may be easier for experienced attackers to recognize as fake. They are mainly used to detect scanning, probing, and other basic attacks on a network.

An example of a low-interaction honeypot is ***Honeyd***. Honeyd works by creating many virtual hosts on one machine and making them look like real systems to attackers. It can mimic different operating systems by copying their ***network stack behavior*** and can simulate services using simple responses. It also uses techniques like ***TCP/IP fingerprinting*** to make the fake systems look more realistic and can simulate entire networks instead of just one device. Honeyd logs incoming traffic and connection attempts, which helps track attacker behavior. Since everything is simulated, it uses very few resources. Typically, Honeyd uses around 5MB of RAM, around 0-5% of the CPU, and only a few megabytes of storage unless a lot of logs are saved. This makes it a lightweight and efficient tool for detecting basic attacks without needing powerful hardware.

### 2. Instructions:
#### Step 1: Scan for Open Ports
First, you need to identify which services the honeypot is pretending to run. Use a network scanning tool like ***nmap***:
<pre> nmap 192.128.0.1 </pre>
This will return a list of open ports.

#### Step 2: Analyze the Results
Look at the output and identify:
* Which ports are open
* What services they appear to be (HTTP, SSH, etc.)

Example:
* Port 80 -> HTTP (web server)
* Port 22 -> SSH

#### Step 3: Interact with Open Ports
Now, Connect to the open ports to see how the honeypot behaves.

If port 80 (HTTP) is open:
- Use curl to send a request:
<pre> curl http://192.128.0.1 </pre>

If port 22 (SSH) is open:
- Try connecting using SSH:
<pre> ssh user@192.128.0.1 </pre>

If other ports are open:
- You can use tools like:
<pre> nc 192.128.0.1 (port_number) </pre>

#### Step 4: Observe Results
Pay attention to:
* What kind of responses you receive
* Whether the service behaves like a real system
* Any unusual or limited behavior

#### Step 5: Document your Findings
Write down:
- Open ports discovered
- Tools/commands used
- Responses from each service
- Anything that seemed “fake” or unusual


### 3. Solution:
Example Solutions:
- Using Curl on Open Port 80:
<pre> 
nmap 192.128.0.1
curl http://192.128.0.1
</pre>
