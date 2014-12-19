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
		domainName=$line		
	else
		echo "Error in service config file"
		exit 1
	fi
    
	let iter+=1
done < $1
IFS=$oldIFS

# Installs NIS service
ssh $2 'apt-get -y install nis' < /dev/null
# Configs remote NIS service
ssh $2 'echo "$domainName" >> /etc/defaultdomain' < /dev/null
ssh $2 '/usr/lib/yp/ypinit -m' < /dev/null
ssh $2 'NISSERVER=master >> /etc/default/nis' < /dev/null
ssh $2 '/etc/init.d/nis restart' < /dev/null