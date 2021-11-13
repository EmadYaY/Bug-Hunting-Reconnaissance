#!/bin/bash

COUNTER=0
for DOMAIN in $(cat $1); do
        python3 /opt/ParamSpider/paramspider.py -d $DOMAIN -o ./$COUNTER-params.txt;
        let COUNTER=COUNTER+1;
done

cat ./*-params.txt > allParams.txt && rm -f ./*-params.txt
cat allParams.txt | gxss -p talson | dalfox pipe --skip-bav -o ./dalfox-POC.txt
echo "XSS Soter has finished scanning `basename $PWD` for XSS vulnerabilites..." > report.txt
echo -n "XSS POCs made: ">> report.txt; cat ./dalfox-POC.txt | wc -l >> report.txt
notify -data report.txt -bulk && rm report.txt
