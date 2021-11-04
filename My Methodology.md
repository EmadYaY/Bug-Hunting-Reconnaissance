### TLDs Recon
 ```
 ~# ./tld_scanner.py -s -n -f -d SITE -m plain -o site-tld.txt
 ```
 ```
 ~# assetfinder [--subs-only] <DOMAIN>
 ```
 ### ASN Enumeration
 
 ```
 ~# ./asnlookup.py -o 'ORG'
 ```
 
 Using Hurricane Electric's [website](https://bgp.he.net/).
 
 ### Port Scanning
 
 
 masscan OR dnmasscan
 
 ```~# masscan -p1-65535 -iL ipFile.txt --max-rate 1800 -oG outPutFile.log```
 
 ```~# dnmasscan domains.txt dns.log [-p1-65535 -oG scan.log]```
 
Service Scanning and Brute Forcing

```
~# cat dns.log | grep -vE '[a-zA-Z=]' |  sort -u  | tail -n +2 > ips.txt
~# masscan -p1-65535 -iL ips.txt --max-rate 1800 -oX masscan-report
~# brutespray -f masscan-report
```
