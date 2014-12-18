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
while read line
do
	linea=$line
	
done < $1
IFS=$oldIFS
