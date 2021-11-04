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

```bash
cat dns.log | grep -vE '[a-zA-Z=]' |  sort -u  | tail -n +2 > ips.txt;
mkdir all-ips && cd all-ips;
split -l 10 ../ips.txt IPs-;
for file in $( ls ); do masscan -p1-65535 -iL $file --max-rate 1800 -oX masscan-report-$file; echo "Port scanning $file file of `basename $PWD` is done." | notify --silent; done; 
for file in $( ls | grep "masscan-report" ); do brutespray -f $file; done; echo "Completed brute forcing default credentials against `basename $PWD`." | notify --silent
```
