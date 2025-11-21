# COSC-3411: Alpha

# Network Reachability and Port Scanner — Alpha Team

## Overview
This project is a Bash script that automatically scans the local network, detects actice devices, checks which ports are open, and tries identifying the operatings system running on each host. It also performs an automated EternalBlue (MS17-010) exploitation using the Metasploit Framework against a vulnerable Windows target.

## Features
- Automatically detects the local IP and calculates the /24 subnet
- Scans all devices on the network using nmap
- Identifies live hosts
- Performs OS detection
- Lists top 100 open TCP ports
- Detects EternalBlue Vulnerability on port 445
- Automatically launched Metasploit and exploits EternalBlue

## Installation Steps
1. Install required packages (Kali usually has them)
```bash
sudo apt update
sudo apt install -y nmap metasploit-framework
```

2. Download the project
```bash
git clone
```








```bash
git clone https://github.com/s4m520/COSC-3411-Alpha.git
cd COSC-3411-Alpha
pip install -r requirements.txt

