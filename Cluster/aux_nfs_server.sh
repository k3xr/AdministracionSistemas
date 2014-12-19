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
	exportedDirs[$(($iter))]=$line	
	let iter+=1
done < "$1"

if [ $iter < 1 ]
then
	echo "Error in nfs server config file (line expected)"
	exit 1
fi
IFS=$oldIFS

# Installs nfs service
ssh $2  'apt-get install -y nfs-common' < /dev/null
ssh $2  'apt-get install -y nfs-kernel-server' < /dev/null

for item in ${exportedDirs[*]}
do
	ssh $2  'echo "$item (rw)" >> /etc/exports' < /dev/null
done