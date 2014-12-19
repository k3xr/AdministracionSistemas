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
		localDirForBackup=$line
		
	elif [ $iter = 1 ]; then
		backupServerAddress=$line
		
	elif [ $iter = 2 ]; then
		remoteDirForBackup=$line
		
	elif [ $iter = 3 ]; then
		backupFrequency=$line
	else
		echo "Error in backup client service config file"
		exit 1
	fi
	let iter+=1
done < $1
IFS=$oldIFS


