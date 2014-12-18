#!/bin/bash

echo "Leyendo el fichero de configuracion"
declare -a ARRAY

IF=$'\n'
while read LINE; do
    ARRAY[$count]=$LINE
    ((count++))
done <"$1"

echo Number of elements: ${#ARRAY[@]}
# echo contenido del array
echo ${ARRAY[@]}

#Array para los dispositivos
declare -a Array_Dispositivos
IF=$' '
read -a Array_Dispositivos <<< "${ARRAY[2]}"

echo "Enviando comando por ssh"

#Realizamos el envio 
#echo 'ssh '$2 'mdadm --create --name='${ARRAY[0]}' --level='${ARRAY[1]}' --raid-devices='${#Array_Dispositivos[*]} ${ARRAY[2]}
echo $2
echo 'ssh '$2  'whoami'