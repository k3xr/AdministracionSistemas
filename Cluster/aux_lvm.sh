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
		volumeGroupName=$line
	elif [ $iter = 1 ]; then
		deviceListInGroup=$line
	else
		volumes[$(($iter-2))]=$linea
	fi    
	let iter+=1
done < $1
IFS=$oldIFS

ssh $2 'pvcreate $deviceListInGroup;vgcreate $volumeGroupName $deviceListInGroup'

for sentence in volumes
do
	iter2=0
	for word in $sentence
	do
		if [ $iter = 0 ]; then
			name=$word
		else
			size=$word
		fi    
		let iter+=1
	done
	
	ssh $2 'lvcreate --name $name --size $size $volumeGroupName'
	
done