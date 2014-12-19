#!/bin/bash

# Checks number of expected args
EXPECTED_ARGS=2

if [ $# -ne $EXPECTED_ARGS ]
then
	echo "Error: $0 not expected args"
    exit 1
fi

# Checks config file
oldIFS=$IFS
IFS="\n"
iter=0
while read line || [[ -n "$line" ]]
do
	if [ $iter = 0 ]; then
		volumeGroupName=$line
	elif [ $iter = 1 ]; then
		deviceListInGroup=$line
	else
		volumes[$(($iter-2))]=$line
	fi    
	let iter+=1
done < "$1"
IFS=$oldIFS

# Install the service
echo "Installing the service -----------------------------------------------"
ssh $2 'apt-get install -y lvm2' < /dev/null
echo "Executing pvcreate $deviceListInGroup --------------------------------"
ssh $2 'pvcreate $deviceListInGroup' < /dev/null 
echo "Executing vgcreate $volumeGroupName $deviceListInGroup ---------------"
ssh $2 'vgcreate $volumeGroupName $deviceListInGroup' < /dev/null

echo "${volumes[0]}"
for sentence in ${volumes[*]}
do
	echo "sentence: $sentence"
	iter3=0
	for word in ${sentence[$iter3]}
	do
		echo "word: $iter3 : $word"
		if [ $iter3 = 0 ]; then
			name=$word
		else
			size=$word
		fi    
		let iter3+=1
	done
	echo "Executing lvcreate --name $name --size $size $volumeGroupName ------"
	ssh $2 'lvcreate --name $name --size $size $volumeGroupName' < /dev/null
done