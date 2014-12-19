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

#Realizamos el envio 
#echo 'ssh '$2 'mdadm --create --name='${ARRAY[0]}' --level='${ARRAY[1]}' --raid-devices='${#Array_Dispositivos[*]} ${ARRAY[2]}

#El /dev/null final hace que no devuelva por pantalla nada
ssh $2 'whoami' < /dev/null > /dev/null