#!/bin/bash

# Checks number of expected args
EXPECTED_ARGS=2

if [ $# -ne $EXPECTED_ARGS ]
then
	echo "Error: $0 not expected args"
    exit 1
fi

# Checks config file
iter=0
while read line || [[ -n "$line" ]]
do
	if [ $iter = 0 ]; then
		deviceName=$line
		echo $deviceName
		
	elif [ $iter = 1 ]; then
		mountPoint=$line
	       	echo $mountPoint
	else
		echo "Error in mount service config file"
		exit 1
	fi
    
	let iter+=1
done < "$1"

# Makes changes permanent
echo "Enviando comando:  mount $deviceName $mountPoint"
ssh $2 sudo mount $deviceName $mountPoint < /dev/null
ssh $2 'echo #File system: $deviceName >> /etc/fstab' < /dev/null
ssh $2 'echo '$deviceName $mountPoint 'auto defaults,auto,rw 0 0 >> /etc/fstab' < /dev/null