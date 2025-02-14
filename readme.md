primero ingresamos al contenedor de /bin/bash en el contenedor del namenode

docker exec  -it namenode /bin/bash 
 
dentro del contenedor ejecutamos los siguientes comandos hadoop

##
listamos en la carpeta

hdfs dfs -ls /datasets/2025-02-13-22

##
verificamos que hay en el archivo segun la ruta 

hdfs dfs -cat /datasets/2025-02-13-22/sdc-a1c94ac2-e8db-11ef-beba-d1a7a754f36f_4842011e-dd47-4a84-8981-fe099783a16e.csv

##
Obtenemos el archivo generado
                                    
                                    
                                    
                                    sdc-a1c94ac2-e8db-11ef-beba-d1a7a754f36f_4842011e-dd47-4a84-8981-fe099783a16e.csv
hdfs dfs -get /datasets/2025-02-13-22/_tmp_sdc-a1c94ac2-e8db-11ef-beba-d1a7a754f36f_0.csv /tmp/prueba.csv


Copiamos del contenedor del namenode para descargar el archivo json que pasó por el pipeline del workshop

docker cp namenode:/tmp/prueba.csv prueba_local.csv