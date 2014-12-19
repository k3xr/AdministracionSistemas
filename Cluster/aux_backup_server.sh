#!/bin/bash

# Checks number of expected args
EXPECTED_ARGS=2

if [ $# -ne $EXPECTED_ARGS ]
then
	echo "Error: not expected args"
    exit 1
fi

# Checks config file
iter=0
while read line || [[ -n "$line" ]]
do
	if [ $iter = 0 ]; then
		backupDir=$line
	else
		echo "Error in backup server service config file"
		exit 1
	fi
	let iter+=1
done < "$1"

ssh $2 mkdir --parents $backupDir < /dev/null