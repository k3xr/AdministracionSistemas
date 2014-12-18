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
while read line
do
	if [ $iter = 0 ]; then
		deviceName=$line
	elif [ $iter = 1 ]; then
		mountPoint=$line
		
		# Makes changes permanent
		ssh $2 'echo "#File system: $deviceName" >> /etc/fstab; echo "$deviceName $mountPoint auto defaults,auto,rw 0 0" >> /etc/fstab'
		
	else
		echo "Error in service config file"
		exit 1
	fi
    
	let iter+=1
done < $1
IFS=$oldIFS
