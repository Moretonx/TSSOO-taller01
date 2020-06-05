#!/bin/bash

# La variable $# es equiv a argc
if [ $# != 1 ]; then
        echo "Uso: $0 <directorio busqueda>"
        exit
fi

searchDir=$1

# Falta verificar que searchDir es realmente un directorio
if [ ! -e $searchDir ]; then
        echo "Directorio $1 no existe"
        exit
fi

printf "Directorio busqueda: %s\n" $1

