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
	remoteDir[$(($iter))]=$line	
	let iter+=1
done < "$1"

# Installs nfs service
ssh $2 apt-get install -y nfs-common -qq --force-yes < /dev/null

for item in ${remoteDir[*]}
do
	ssh $2 'echo '$item' nfs defaults,auto 0 0 >> /etc/fstab' < /dev/null
done