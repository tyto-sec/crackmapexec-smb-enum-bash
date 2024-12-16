#!/bin/bash

echo -e "\nCrackmapexec SMB Enum "
echo "Written by tyto"

if [ -z "$1" ]; then
    echo "Example: $0 192.168.0.0/24"
else
    echo ""
    nmap --open -sS -g 53 -p 445 -Pn $1 -oG nmap_out
    if ! [[ ! -s "nmap_out" || -z "$(grep -o '[^[:space:]]' "nmap_out")" ]]; then
        cat nmap_out | grep "Up" | cut -d " " -f 2 > hosts
	echo ""
	if [[ -s hosts ]]; then
		crackmapexec smb $(<hosts)
		rm hosts
	fi
    	rm nmap_out
    fi
    echo ""
fi
