#!/bin/bash

# Checks number of expected args
EXPECTED_ARGS=1

if [ $# -ne $EXPECTED_ARGS ]
then
    echo "Use: $0 <config_file>"
    exit 1
fi

# Checks config file
IFS=" ,#"
while read maquina service config || [[ -n "$maquina" ]]
do
    if [ ! -z $maquina ] || [ ! -z $service ] || [ ! -z $config ] 
    then
	echo "Executing: $maquina $service $config"
	
	# Ponemos un switch case para actuar segun el servicio
	case $service in
		mount)
			sudo ./aux_mount.sh $config $maquina;;
	    raid)
       		sudo ./aux_raid.sh $config $maquina;;
	    lvm)
			sudo ./aux_lvm.sh $config $maquina;;
	    nis_server)
			sudo ./aux_nis_server.sh $config $maquina;;
	    nis_client)
			sudo ./aux_nis_client.sh $config $maquina;;
	    nfs_server)
			sudo ./aux_nfs_server.sh $config $maquina;;
	    nfs_client)
			sudo ./aux_nfs_client.sh $config $maquina;;
	    backup_server)
			sudo ./aux_backup_server.sh $config $maquina;;
	    backup_client)
			sudo ./aux_backup_client.sh $config $maquina;;
	esac

    fi
done < "$1"
