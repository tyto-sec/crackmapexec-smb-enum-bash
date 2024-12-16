# CrackMapExec SMB Enumeration Script

This Bash script automates the enumeration of SMB services on a specified network range. It uses `nmap` to identify hosts with port 445 open and `crackmapexec` to enumerate SMB services on those hosts. The script helps streamline the process of identifying accessible SMB shares within a network.

## Prerequisites

- **Nmap**: Ensure `nmap` is installed on your system. Install it with:
  ```bash
  sudo apt install nmap
  ```

- **CrackMapExec**: Ensure `crackmapexec` is installed. Install it with:
  ```bash
  sudo apt install crackmapexec
  ```

- **Bash Shell**: Compatible with Unix-like systems (Linux, macOS).

- **Root/Administrator Privileges**: Requires elevated permissions to perform SYN scans.

## Usage

Run the script with the target network range in CIDR notation:

```bash
sudo ./crackmapexec-smb-enum.sh <network>
```

### Example

```bash
sudo ./crackmapexec-smb-enum.sh 192.168.0.0/24
```

## How It Works

1. **Nmap Scan**: Performs a SYN scan on port 445 using source port 53 to identify SMB-enabled hosts:
   ```bash
   nmap --open -sS -g 53 -p 445 -Pn <network> -oG nmap_out
   ```
   
2. **Filter Hosts**: Extracts IP addresses of hosts that are up and have port 445 open:
   ```bash
   cat nmap_out | grep "Up" | cut -d " " -f 2 > hosts
   ```

3. **CrackMapExec Execution**: Runs `crackmapexec` to enumerate SMB services on the identified hosts:
   ```bash
   crackmapexec smb $(<hosts)
   ```

## Notes

- **Permissions**: Ensure you run the script with `sudo` or root privileges to perform the `nmap` SYN scan.
- **Network Scope**: Only use this script on networks you are authorized to scan.
- **Source Port Spoofing**: The script uses `-g 53` to bypass basic firewall rules that may block SYN scans.

## Author

Written by tyto.
