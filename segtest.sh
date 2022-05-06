#!/bin/bash

MAIN=$PWD
# Create output format
DATENUMS=$(date | tr -dc '0-9')
OUT=$(echo $1 | sed -r 's/\//_/g')-$DATENUMS
mkdir logs/$OUT

echo "[+] Received $1 as target parameter..."
echo "[+] Starting TCP nmap scan on all ports..."
nmap -sC -Pn -T4 -vv -n $1 -p- -oA logs/$OUT/tcp -oG logs/$OUT/tcp

echo "[+] Starting UDP nmap scan on top 1,000 ports..."
nmap -sC -sU -Pn -T4 -vv -n $1 --top-ports 1000 -oA logs/$OUT/udp -oG logs/$OUT/udp

echo "[+] Running WitnessMe on results..."
cd logs/$OUT
witnessme screenshot ./*.xml

echo "[+] Exporting results to CSV..."
cat tcp udp | egrep -o '[0-9]+(\.[0-9]+)+.+\/\/\/' \
    | sed -r 's/,//g' | sed -r 's/ \(\)\tPorts: /,/g' | sed -r 's/\/\s/\/\n,/g' \
    | sed -r 's/\/\/\///g' | sed -r 's/\/\//,/g' | sed -r 's/\//,/g' > results.csv

echo "[+] Cleaning up results..."
cd $MAIN
python3 utils/csv-clean.py ./logs/$OUT/results.csv

echo "[+] Done! Saved to logs/$OUT"