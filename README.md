## Autor
Francisco Moretti Castro

## Correo institucional
francisco.moretti@alumnos.uv.cl

Para poder buscar los archivos de simulación de debe ingresar la ubicación del directorio por parametro al archivo stats.sh.  

En la búsqueda de archivos específicos se hace de la siguiente manera:  

    `find $searchDir -name '*NombreArchivo*.txt' -print | sort | grep -v '._'`

Para ingresar datos a un archivo de texto lo hacemos asi:
    printf "$Total \n" >>$File1    o así    `printf "%i %i %i\n" $temp1 >> $file1`

En el __ejercicio 1__ leemos desde la segunda linea indicando el separador ":"

	Suma=$(cat $i | tail -n+2 | awk -F ':'

En los archivos executionSummary-NNN.txt los tiempos de simulación estás en la posición 6, 7 y 8. Entonces se sumas así: suma=$6+$7+$8
La memoria del simulador esta en la posición $9.

Para el __ejercicio 2__ en los archivos archivos summary-NNN.txt los tiempos de evacuación están en $8.
Además el indicador de modelo de persona está en $3 y el indicador de grupo etario está en $4.

En el __ejercicio 3__ en los archivos usePhone-NNN.txt el número de personas que ocupan el teléfono movil están en $3
en los tiempo de medición $2.
