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
	elif [ $iter = 1 ]; then
		serverToConnect=$line
		
		# Connects to nis server (ypbind). Configuration in /etc/yp.conf + /etc/nsswitch		
		ssh $2  'echo "ypserver $serverToConnect" >> /etc/yp.conf' < /dev/null
		ssh $2  '/etc/init.d/nis start' < /dev/null
	else
		echo "Error in service config file"
		exit 1
	fi
    
	let iter+=1
done < "$1"
IFS=$oldIFS