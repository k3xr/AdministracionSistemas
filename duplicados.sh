#!/bin/bash
# Oscarf

declare -a checksums

iter=0

for file in **; do

  checksum=($(md5sum $file))
    
  i=0
  match=0
  while [ $i -lt ${#checksums[*]} ]
  do
    # If it matches other md5sum its duplicated
    if [ ${checksums[$i]}=$checksum ]
    then
	echo $file duplicated
	match=1
    fi
  ((i++))
  done
  
  # if it doesnt matches any other md5sum it isnt duplicated and it is added to the array
  if [ $match -ne 1 ]
  then
    checksums[iter]=$checksum
  fi
   
  ((iter+=1))
done