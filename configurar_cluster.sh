#!/bin/bash

# Comprobamos que solo nos pasan un argumento
EXPECTED_ARGS=1

if [ $# -ne $EXPECTED_ARGS ]
then
    echo "Use: $0 <fichero_configuración>"
    exit 1
fi

# Aqui se comprueba que el archivo de configurado 
IFS=" ,#"
while read var1 var2 var3
do
    if [ ! -z $var1 ] || [ ! -z $var2 ] || [ ! -z $var3 ] 
    then
	echo "Linea leida: $var1  $var2 $var3"
    fi
done < "$1"
