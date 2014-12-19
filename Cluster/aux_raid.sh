#!/bin/bash

#echo "Leyendo el fichero de configuracion"
declare -a ARRAY

IFS=$'\n'
while read LINE || [[ -n "$LINE" ]]; do
    ARRAY[$count]=$LINE
    ((count++))
    
done <"$1"

#echo Number of elements: ${#ARRAY[@]}
#echo contenido del array
#echo ${ARRAY[@]}

#Array para los dispositivos
declare -a Array_Dispositivos
IFS=$' '
read -a Array_Dispositivos <<< "${ARRAY[2]}"

echo "Enviando comando por ssh "

#Primero debemos instalar mdadm
ssh $2 sudo apt-get install mdadm > /dev/null

#Realizamos el envio 
echo "ssh sudo $2 mdadm --create --name=${ARRAY[0]} --metadata=0.90 --level=${ARRAY[1]} --raid-devices=${#Array_Dispositivos[*]} ${ARRAY[0]} ${ARRAY[2]}"

ssh $2 sudo mdadm --create --name=${ARRAY[0]} --level=${ARRAY[1]} --metadata=0.90 --raid-devices=${#Array_Dispositivos[*]} ${ARRAY[0]} ${ARRAY[2]} < /dev/null