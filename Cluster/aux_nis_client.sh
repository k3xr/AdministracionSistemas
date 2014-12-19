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
		domainName=$line
		
	elif [ $iter = 1 ]; then
		serverToConnect=$line
		
	else
		echo "Error in nis client service config file"
		exit 1
	fi
    
	let iter+=1
done < "$1"

# Installs NIS service
ssh $2 apt-get -y install nis -qq --force-yes < /dev/null > /dev/null
# Connects to remote NIS server (ypbind). Configuration in /etc/yp.conf + /etc/nsswitch		
ssh $2 'echo domain '$domainName' server '$serverToConnect' >> /etc/yp.conf' < /dev/null
ssh $2 /etc/init.d/nis start < /dev/null