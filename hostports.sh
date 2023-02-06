#!/bin/bash

function ctrl_c(){
echo -e "\n\n [!] Leaving...\n"
tput cnorm; exit 1
}

#Ctrl+C
trap ctrl_c INT

tput civis

#Main Function

host_scan () {
  for i in $(seq 2 254); do
    timeout 1 bash -c "ping -c 1 10.10.0.$i" &>/dev/null
    if [ $? -eq 0 ]; then
    for port in $(seq 1 65535); do
      timeout 1 bash -c "echo '' > /dev/tcp/10.10.0.$i/$port" &>/dev/null
      if [ $? -eq 0 ]; then
      echo "[+] Host 10.10.0.$i ACTIVE & PORT $port OPEN" &
      fi
  done; wait
  else
    echo "[+] Host 10.10.0.$i - ACTIVE" &
  fi

  done; wait
}

tput cnorm

main() {
host_scan
}
main
