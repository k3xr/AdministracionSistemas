
#!bin/bash
# El numero de argumentos debe ser menor de 7 y mayor de 0

if [ $# -ge 6 ] || [ $# -le 0 ];
then
echo "uso: ./crear_conjunto <nombre_usuario_base> [-n numero_a_crear] [-g grupo]"
exit 1
fi

# Guardamos el parametro del nombre base de los usuarios
base=$1
# Saltamos el primer argumento para posteriormente usar getops
shift

n=0

# Todos los parametros que queremos que acompañen a un valor llevan tras ellos un (:), si colocamos
# al principio activamos el modo silent error reporting

while getopts ":n:g:" o; do
case "$o" in
n)
n=${OPTARG}
;;
g)
g=${OPTARG}
;;
esac
done

# Creamos el grupo en caso de que se haya especificado como parametro
if [ -n "$g" ]
then
groupadd $g
fi

# Bucle para la creacion de tantos usuarios como se hayan pasado como argumento -n
# si no se especifica se crean 5 usuarios
if [ $n -eq 0 ]
then
n=5
fi

while [ $n -gt 0 ]; do
# En el caso de que no se haya introducido el argumento para el grupo
if [ -z "$g" ]
then
# Creamos el grupo
groupadd $base$n
# Creamos el usuario y le asignamos el grupo con su nombre
useradd $base$n -g $base$n
else
# En este caso creamos los usuarios con el grupo introducido por argumentos
useradd $base$n -g $g
fi
n=$((n-1))
done

exit 0
