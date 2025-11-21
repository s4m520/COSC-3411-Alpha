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
1. Install required packages (Kali usually has them):
```bash
sudo apt install -y nmap metasploit-framework
```

2. Download the project:
```bash
git clone https://github.com/s4m520/COSC-3411-Alpha.git
```

3. Move into the project folder:
```bash
cd COSC-3411-Alpha
ls
```
Inside, you should see:
```bash
README.md  Scanner
```

4. Move into the Scanner folder:
```bash
cd Scanner
```
Inside, you should see:
```bash
scanner.sh
```

5. Make sure the script is executable:
```bash
chmod +x scanner.sh
```

6. Run the tool (with root privileges):
```bash
sudo ./scanner.sh
```

## Usage Example (What you will see):
```bash
Scanning Devices Connected to: 192.168.1.0/24

Device          | Operating System         | Open Ports
-------------------------------------------------------------
192.168.1.10    | Windows 7 SP1            | ports: 135 139 445
192.168.1.15    | unknown                  | ports: none-shown
192.168.1.21    | Linux Kernel 5.x         | ports: 22 80

[!] 192.168.1.10: MS17-010 / EternalBlue detected

Exploiting 192.168.1.10 ...
Launching Metasploit...

```

## Important:
Make sure:
- port 445 is open on the victim machine and firewall is turned off
- both machines are on the same LAN
- You are using Kali as the attacker
