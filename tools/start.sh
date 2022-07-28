#!/bin/sh
./generate-cert.sh
service squid start
iodined -c -f -P $PASSWORD -n $EXT_IP $INT_IP $DOMAIN