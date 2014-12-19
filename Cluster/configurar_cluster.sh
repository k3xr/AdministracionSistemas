#!/bin/bash

# Comprobamos que solo nos pasan un argumento
EXPECTED_ARGS=1

if [ $# -ne $EXPECTED_ARGS ]
then
    echo "Use: $0 <fichero_configuracion>"
    exit 1
fi

# Aqui se comprueba el archivo de configuracion 
IFS=" ,#"
while read maquina servicio config || [[ -n "$line" ]]
do
    if [ ! -z $maquina ] || [ ! -z $servicio ] || [ ! -z $config ] 
    then
	echo "Linea leida: $maquina $servicio $config"
	
	#Ponemos un switch case para actuar segun el servicio
	case $servicio in
	    mount)
	       	./aux_mount.sh $config $maquina;;
	    raid)
       		./aux_raid.sh $config $maquina;;
	    lvm)
			./aux_lvm.sh $config $maquina;;
	    nis_server)
			./aux_nis_server.sh $config $maquina;;
	    nis_client)
			./aux_nis_client.sh $config $maquina;;
	    nfs_server)
			./aux_nfs_server.sh $config $maquina;;
	    nfs_client)
			./aux_nfs_client.sh $config $maquina;;
	    backup_server)
			./aux_backup_server.sh $config $maquina;;
	    backup_client)
			./aux_backup_client.sh $config $maquina;;
	esac

    fi
done < "$1"