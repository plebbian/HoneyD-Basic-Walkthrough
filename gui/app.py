from flask import Flask, render_template, jsonify, request, send_file
import docker
import io
from collections import deque
from datetime import datetime
import threading
import json
import os
import sys

app = Flask(__name__)

# Connect to Docker daemon
try:
    client = docker.from_env()
except Exception as e:
    print("Error connecting to Docker: " + str(e))
    client = None

# Store logs
logs = deque(maxlen=1000)
log_lock = threading.Lock()

# Sample challenges (you can load these from a JSON file)
CHALLENGES = [
    {
        "id": "challenge1",
        "title": "Port Scanning Detection",
        "description": "Trigger a port scan against the honeypot and observe detection.",
        "hint": "Use nmap to scan the honeypot network"
    },
    {
        "id": "challenge2",
        "title": "SSH Brute Force",
        "description": "Attempt SSH login to trigger honeypot response.",
        "hint": "Try common credentials against the SSH service"
    },
    {
        "id": "challenge3",
        "title": "Web Exploitation",
        "description": "Interact with the honeypot's web service.",
        "hint": "Check for common web vulnerabilities"
    }
]

def get_honeyd_container():
    """Get the active honeyd container"""
    if not client:
        return None
    
    try:
        # Try honeyd-compat first (more common), fall back to honeyd-linux
        try:
            return client.containers.get('honeyd-compat')
        except Exception:
            try:
                return client.containers.get('honeyd-linux')
            except Exception:
                return None
    except Exception as e:
        print("Error getting container: " + str(e))
        return None

def stream_logs_background():
    """Stream logs from honeyd container in the background"""
    container = get_honeyd_container()
    if not container:
        with log_lock:
            logs.append("Error: Could not connect to honeyd container\n")
        return
    
    try:
        for line in container.logs(stream=True):
            with log_lock:
                timestamp = datetime.now().strftime('%H:%M:%S')
                # Handle both bytes and strings for older Python versions
                if isinstance(line, bytes):
                    clean_line = line.decode('utf-8').strip()
                else:
                    clean_line = line.strip()
                if clean_line:  # Don't add empty lines
                    logs.append("[" + timestamp + "] " + clean_line + "\n")
    except Exception as e:
        with log_lock:
            logs.append("Log stream error: " + str(e) + "\n")

# web pages

@app.route('/')
def index():
    return render_template('index.html')

@app.route('/about.html')
def about():
    return render_template('about.html')

@app.route('/docs.html')
def docs():
    return render_template('docs.html')

@app.route('/api/logs')
def get_logs():
    """Return all current logs"""
    with log_lock:
        return jsonify({"logs": list(logs)})

@app.route('/api/challenges')
def get_challenges():
    """Return list of available challenges"""
    return jsonify(CHALLENGES)

@app.route('/api/challenge/<challenge_id>', methods=['POST'])
def activate_challenge(challenge_id):
    """Activate a specific challenge"""
    challenge = None
    for ch in CHALLENGES:
        if ch['id'] == challenge_id:
            challenge = ch
            break
    
    if not challenge:
        return jsonify({"status": "error", "message": "Challenge not found"}), 404
    
    container = get_honeyd_container()
    if not container:
        return jsonify({"status": "error", "message": "Container not available"}), 500
    
    try:
        # Log the challenge activation
        with log_lock:
            logs.append("\n[SYSTEM] Challenge activated: " + challenge['title'] + "\n")
        
        # WIP 

        return jsonify({
            "status": "success",
            "message": "Challenge '" + challenge['title'] + "' activated"
        })
    except Exception as e:
        return jsonify({"status": "error", "message": str(e)}), 500

@app.route('/api/status')
def get_status():
    """Get container status"""
    container = get_honeyd_container()
    if not container:
        return jsonify({"status": "error", "message": "Container not found"}), 500
    
    try:
        container.reload()
        return jsonify({
            "status": container.status,
            "running": container.status == "running"
        })
    except Exception as e:
        return jsonify({"error": str(e)}), 500

@app.route('/api/download-logs')
def download_logs():
    """Download logs as a text file"""
    with log_lock:
        log_content = ''.join(logs)
    
    log_file = io.BytesIO(log_content.encode('utf-8'))
    return send_file(
        log_file,
        mimetype='text/plain',
        as_attachment=True,
        download_name='honeyd_logs.txt'
    )

@app.route('/api/pcap')
def download_pcap():
    """Download latest PCAP file (if available)"""
    container = get_honeyd_container()
    if not container:
        return jsonify({"error": "Container not available"}), 500
    
    try:
        # assumes there is PCAP files in /opt/honeyd/pcaps/
        exit_code, output = container.exec_run('ls -t /opt/honeyd/pcaps/*.pcap | head -1')
        
        if isinstance(output, bytes):
            pcap_path = output.decode('utf-8').strip()
        else:
            pcap_path = output.strip()
        
        if not pcap_path:
            return jsonify({"error": "No PCAP files found"}), 404
        
        return jsonify({"message": "PCAP download functionality needs volume setup"})
    
    except Exception as e:
        return jsonify({"error": str(e)}), 500

@app.route('/api/analysis', methods=['POST'])
def run_analysis():
    """Run analysis on honeypot data"""
    container = get_honeyd_container()
    if not container:
        return jsonify({"error": "Container not available"}), 500
    
    try:
        # Example: run a simple analysis script
        exit_code, output = container.exec_run('bash /opt/honeyd/scripts/analyze.sh')
        
        if isinstance(output, bytes):
            output_str = output.decode('utf-8')
        else:
            output_str = output
        
        with log_lock:
            logs.append("\n[SYSTEM] Analysis completed\n")
        
        return jsonify({
            "status": "success",
            "analysis": output_str
        })
    except Exception as e:
        return jsonify({"error": str(e)}), 500

# Start log streaming in background thread
log_thread = threading.Thread(target=stream_logs_background)
log_thread.daemon = True
log_thread.start()

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=False, threaded=True)
