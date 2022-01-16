#!/bin/bash

#####################
### Prerequists:  ###
### - anew        ###
### - ParamSpider ###
### - Dalfox      ###
### - Gxss        ###
#####################

if [[ $# -eq 0 ]] ; then
    echo "Usage: ${0##*/} <domains list>"
    exit 1
fi
COUNTER=0
for DOMAIN in $(cat $1); do
        python3 /opt/ParamSpider/paramspider.py -d $DOMAIN -o ./xssoter/$COUNTER-params.txt;
        let COUNTER=COUNTER+1;
        sleep 0.2;
done

cat ./xssoter/*-params.txt > ./xssoter/allParams.txt && rm -f ./xssoter/*-params.txt
cat ./xssoter/allParams.txt | Gxss -p talson | anew ./xssoter/allParams-test.txt
dalfox file ./xssoter/allParams-test.txt  --skip-bav -o ./dalfox-POC.txt
echo "XSS Soter has finished scanning `basename $PWD` for XSS vulnerabilites..." > report.txt
echo -n "XSS POCs made: ">> report.txt; cat ./dalfox-POC.txt | wc -l >> report.txt
notify -data report.txt -bulk --silent && rm report.txt
