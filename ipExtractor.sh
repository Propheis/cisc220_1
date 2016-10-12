#!/bin/bash
ifconfig 1> ipAddress.txt
addr=$(grep -e "inet addr:" ipAddress.txt | awk '{print $1,$2}' | awk -F ":" '{print $2}')
for val in $addr; do
	if [[ $val == 	127* ]]; then
		echo $val "Local IP"
	elif  ([[ $val == 10* ]] || [[ $val == 192.168* ]]); then
		echo $val "Private IP"
	else
		echo $val "Public IP"
	fi
done
