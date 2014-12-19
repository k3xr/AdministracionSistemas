#!/bin/bash

# Checks number of expected args
EXPECTED_ARGS=2

if [ $# -ne $EXPECTED_ARGS ]
then
	echo "Error: not expected args"
    exit 1
fi

# Checks config file
oldIFS=$IFS
IFS="\n"
iter=0
while read line || [[ -n "$line" ]]
do
	if [ $iter = 0 ]; then
		domainName=$line		
	else
		echo "Error in service config file"
		exit 1
	fi
    
	let iter+=1
done < $1
IFS=$oldIFS

ssh $2 "'/usr/lib/yp/ypinit -m;NISSERVER=master >> /etc/default/nis;/etc/init.d/nis restart'"