#!/bin/bash

COUNTER=0
for DOMAIN in $(cat rootdomains); do
        python3 /opt/ParamSpider/paramspider.py -d $DOMAIN -o ./$COUNTER-params.txt;
        let COUNTER=COUNTER+1; 
done

cat ./*-params.txt > allParams.txt && rm -f ./*-params.txt
cat allParams.txt | gxss -p talson | dalfox pipe --skip-bav -o ./dalfox-POC.txt
