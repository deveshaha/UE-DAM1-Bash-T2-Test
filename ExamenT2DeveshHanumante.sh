#!/bin/bash

#menu interativo
while true
do
    clear
    echo "1) Crear usuario"
    echo "2) Crear fichero"
    echo "3) Modificar propiedades de un fichero"
    echo "4) Salir"
    echo "Seleccione una opcion: "

    read opcion
    case $opcion in
        1)  
            echo "############################################################"
            echo "Introduzca el nombre del usuario: "
            read usuario

            if id -u $usuario >/dev/null 2>&1; 
            then
                echo "El usuario $usuario ya existe"
                echo "El UID del usuario $usuario es: $(id -u $usuario)"
                echo "############################################################"
                sleep 5
                read -p "Pulsa una tecla para continuar"
            else

                echo "############################################################"
                echo "Creando usuario $usuario"
                useradd $usuario
                echo "El UID del usuario $usuario es: $(id -u $usuario)"
                echo "############################################################"
                sleep 5
                read -p "Pulsa una tecla para continuar"
            fi
            ;;

        2) 
            echo "############################################################"
            echo "Introduzca el nombre del fichero: "
            read nombre
            cd /home/dev01/Documents
            if [ -f $nombre ]; 
            then
                echo "El fichero $nombre ya existe"
                if [ -d $nombre ]; 
                then
                    echo "El fichero $nombre es un directorio"
                else
                    echo "El fichero $nombre es un fichero"
                fi
                echo "############################################################"
                sleep 5
                read -p "Pulsa una tecla para continuar"
            else
                echo "############################################################"
                echo "Creando fichero $nombre"
                cd /home/dev01/Documents
                touch $nombre
                echo "El fichero $nombre se ha creado en: $(pwd)"
                echo "############################################################"
                sleep 5
                read -p "Pulsa una tecla para continuar"
            fi
            ;;
        
        3)
            echo "############################################################"
            echo "Introduce el usuario al que se le quiere adjudicar la propiedad del fichero"
            read user

            if id -u $user >/dev/null 2>&1;
            then

            echo "Introduce el grupo al que se le quiere adjudicar la propiedad del fichero"
            read grupo

                if id -g $grupo >/dev/null 2>&1;
                then
                    chown $user:$grupo $nombre
                    echo "Permisos y propietario del fichero $nombre"
                    ls -l $nombre
                    echo "############################################################"
                    sleep 5
                    read -p "Pulsa una tecla para continuar"
                else
                    chown $user $nombre
                    echo "Permisos y propietario del fichero $nombre"
                    ls -l $nombre
                    echo "############################################################"
                    sleep 5
                    read -p "Pulsa una tecla para continuar"
                fi

            else
                echo "El usuario $user no existe"
                echo "############################################################"
                sleep 5
                read -p "Pulsa una tecla para continuar"
            fi
            ;;

        4) 
            echo "############################################################"
            echo "Saliendo..."
            echo "############################################################"
            sleep 5
            break
            ;;

        *)
            echo "Opcion incorrecta"
            sleep 5
            break
            ;;


    esac
    echo "Pulse una tecla para continuar"
    read
done