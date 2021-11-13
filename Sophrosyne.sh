#!/bin/bash

##########################################################################
#######! You can do a for loop to iterate upon a list of domains: !#######
###! for domain in $(cat rootdomains); do sophrosyne.sh $domain; done !###
##########################################################################

crtsh(){
    OKBLUE='\033[94m'
    OKRED='\033[91m'
    OKGREEN='\033[92m'
    OKORANGE='\033[93m'
    RESET='\e[0m'
    TARGET="$1"

    if [ -z $1 ]; then
      echo -e "$OKRED            _         _     $RESET"
      echo -e "$OKRED   ___ _ __| |_   ___| |__  $RESET"
      echo -e "$OKRED  / __| '__| __| / __| '_ \ $RESET"
      echo -e "$OKRED | (__| |  | |_ _\__ \ | | |$RESET"
      echo -e "$OKRED  \___|_|   \__(_)___/_| |_|$RESET"
        echo ""
      echo -e "$OKRED [+] by 1N3@CrowdShield$RESET"
      echo -e "$OKRED [+] https://crowdshield.com$RESET"
      echo -e "$OKRED [-] Usage: crt.sh <target>$RESET"
      exit
    fi

    if [[ $1 = "--help" ]]; then
      echo -e "$OKRED            _         _     $RESET"
      echo -e "$OKRED   ___ _ __| |_   ___| |__  $RESET"
      echo -e "$OKRED  / __| '__| __| / __| '_ \ $RESET"
      echo -e "$OKRED | (__| |  | |_ _\__ \ | | |$RESET"
      echo -e "$OKRED  \___|_|   \__(_)___/_| |_|$RESET"
        echo ""
      echo -e "$OKRED [-] Usage: crt.sh <target>$RESET"
      exit
    fi

    echo -e "$OKRED            _         _     $RESET"
    echo -e "$OKRED   ___ _ __| |_   ___| |__  $RESET"
    echo -e "$OKRED  / __| '__| __| / __| '_ \ $RESET"
    echo -e "$OKRED | (__| |  | |_ _\__ \ | | |$RESET"
    echo -e "$OKRED  \___|_|   \__(_)___/_| |_|$RESET"
    echo ""
    echo -e "$OKRED + -- ----------------------------=[Gathering Certificate Subdomains]=-------- -- +$RESET"
    curl -s https://crt.sh/?q=%25.$1 > /tmp/curl.out
    cat /tmp/curl.out | grep $1 | grep TD | sed -e 's/\*\.//g' | sed -e 's/>//g' | sed -e 's/TD//g' | sed -e 's/\///g' | sed -e 's/ //g' | sed -n '1!p' | sed -e 's/BR/\n/g' | sort -u > $1-crt.txt
    cat $1-crt.txt
    echo -e "$OKRED [+] Domains saved to: $1-crt.txt"
    echo -e "$OKRED + -- ----------------------------=[Done!]=----------------------------------- -- +$RESET" 
}

sophrosyne(){
    mkdir crt && cd crt
    crtsh $1
    cat * | anew ../rootdomains
    cd ../
    rm -rf crt
    sed -r 's/<//g' rootdomains | grep -v '@' | sort -u > temp; mv temp rootdomains
    grep -Ev '\.com[a-zA-Z]' rootdomains > temp; mv temp rootdomains
}

sophrosyne $1
