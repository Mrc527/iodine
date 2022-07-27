#!/bin/sh
./generate-cert.sh
service squid start
iodined -c -f $INT_IP -P $PASSWORD -n $EXP_IP $DOMAIN