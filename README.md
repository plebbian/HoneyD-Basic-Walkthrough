# HoneyD-Basic-Walkthrough
This repo is a quick, fun way to get familiar with how to interact with a fake network as a hacker using reconnaissance commands while also playing the part as an observer of the honeypot network.

---

# Setup and Containerization

---

The setup implements a network honeypot using:

* **Honeyd** - network-level deception tool
* **Snap7 PLC server** - backend simulation
* **Docker** - repeatable deployment
* **PLCinject** - attack tool to test environment

The system uses PLCinject to attack the fake network (HoneyD) which has a virtual PLC device. The incoming traffic to the PLC is intercepted and sent to the fake server (Snap7). The backend server responds with valid data, decieving the attacker into thinking the data being sent back is real.

* Fake PLC IP: 192.168.0.125
* Protocol: S7 (TCP port 102)
