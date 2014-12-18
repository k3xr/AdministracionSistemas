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
while read maquinaIp servicio config
do
    if [ ! -z $maquina ] || [ ! -z $servicio ] || [ ! -z $config ] 
    then
	echo "Linea leida: $maquina $servicio $config"
	
	#Ponemos un switch case para actuar segun el servicio
	case $servicio in
	    mount)
			./auxiliar/aux_mount.sh $config;;
	    raid)
			./auxiliar/aux_raid.sh $config;;
	    lvm)
			./auxiliar/aux_lvm.sh $config;;
	    nis_server)
			./auxiliar/aux_nis_server.sh $config;;
	    nis_client)
			./auxiliar/aux_nis_client.sh $config;;
	    nfs_server)
			./auxiliar/aux_nfs_server.sh $config;;
	    nfs_client)
			./auxiliar/aux_nfs_client.sh $config;;
	    backup_server)
			./auxiliar/aux_backup_server.sh $config;;
	    backup_client)
			./auxiliar/aux_backup_client.sh $config;;
	esac

    fi
done < "$1"