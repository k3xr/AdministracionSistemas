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
ssh $2 'apt-get install -y lvm2 -qq --force-yes' < /dev/null
echo "Executing pvcreate $deviceListInGroup --------------------------------"
ssh $2 'pvcreate $deviceListInGroup' < /dev/null 
echo "Executing vgcreate $volumeGroupName $deviceListInGroup ---------------"
ssh $2 'vgcreate $volumeGroupName $deviceListInGroup' < /dev/null

for sentence in ${volumes[*]}
do
IFS=$' '
    read -a volume <<< "$sentence"
    name_vol = ${volume[0]}
    size_vol = ${volume[1]}	
	ssh $2 'lvcreate --name $name_vol --size $size_vol $volumeGroupName' < /dev/null
done