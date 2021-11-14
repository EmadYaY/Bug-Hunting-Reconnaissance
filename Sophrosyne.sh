#!/bin/bash

##########################################################################
#######! You can do a for loop to iterate upon a list of domains: !#######
###! for domain in $(cat rootdomains); do sophrosyne.sh $domain; done !###
################ You need to install 'anew' by tomnomnom #################
##########################################################################

if [[ $# -eq 0 ]] ; then
    echo -e "$OKRED [!] Usage: ${0##*/} <DOMAIN>"
    exit 1
fi

crtsh(){
    BLUE='\033[94m'
    RED='\033[91m'
    GREEN='\033[92m'
    ORANGE='\033[93m'
    RESET='\e[0m'

    echo -e "$RED [-] Gathering Certificate Subdomains..."
    curl -s https://crt.sh/?q=%25.$1 > /tmp/curl.out
    cat /tmp/curl.out | grep $1 | grep TD | sed -e 's/\*\.//g' | sed -e 's/>//g' | sed -e 's/TD//g' | sed -e 's/\///g' | sed -e 's/ //g' | sed -n '1!p' | sed -e 's/BR/\n/g' | sed -r 's/<//g' | grep -v '@' | sort -u > $1-crt.txt
    cat $1-crt.txt
    echo -e "$GREEN [+] Domains saved to: rootdomains.txt"
    echo -e "$GREEN [-] Done!" 
}

sophrosyne(){
    mkdir crt && cd crt
    crtsh $1
    cat * | anew ../rootdomains
    cd ../
    rm -rf crt
    grep -Ev '\.com[a-zA-Z]' rootdomains > temp; mv temp rootdomains
}

sophrosyne $1
