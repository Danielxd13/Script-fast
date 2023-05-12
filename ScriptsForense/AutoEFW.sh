#!/bin/bash

# Script que no hace nada pero comprueba si una carpeta existe y la crea si no existe

# Recibe 3 variables
unidad="$1"
usuario="$2"
carpeta="$3"

# Comprobamos si la unidad montada existe
if ! mount | grep -q "$unidad"; then
  # La unidad no est� montada
  echo "La unidad $unidad no est� montada. No se puede continuar."
  exit 1
fi

# Comprobamos si la carpeta existe
if [ ! -d "$carpeta" ]; then
  # La carpeta no existe, la creamos
  echo "La carpeta $carpeta no existe, se crear� autom�ticamente."
  mkdir -p "$carpeta"
else
  # La carpeta ya existe
  echo "La carpeta $carpeta ya existe."
fi

# Recopilamos informaci�n del sistema
echo "Recopilando informaci�n del sistema..."
mkdir $carpeta/informacion-sistema
cat $unidad/etc/*release* >> $carpeta/informacion-sistema/sistema.txt
cat $unidad/proc/meminfo > $carpeta/informacion-sistema/memoria.txt


# Recuperamos registros de actividad del sistema
echo "Recuperando registros de actividad del sistema..."
mkdir $carpeta/registros-sistema
cp $unidad/var/log/auth.log $carpeta/registros-sistema/auth.log
cp $unidad/var/log/dmesg $carpeta/registros-sistema/dmesg.log
cp $unidad/var/log/kern.log $carpeta/registros-sistema/kern.log
cp $unidad/var/log/syslog $carpeta/registros-sistema/syslog.log
cp $unidad/var/log/lastlog $carpeta/registros-sistema/lastlog
last -i $unidad/var/log/wtmp >  $carpeta/registros-sistema/inicio_sesion.txt
last -if $unidad/var/log/wtmp >  $carpeta/registros-sistema/inicio_sesion.txt
lastb -i $unidad/var/log/btmp >  $carpeta/registros-sistema/inicio_sesion_fallido.txt
lastb -if $unidad/var/log/btmp >  $carpeta/registros-sistema/inicio_sesionfallido.txt

# Recuperamos archivos de configuraci�n importantes
echo "Recuperando archivos de configuraci�n..."
mkdir $carpeta/archivos-configuracion
cp $unidad/etc/fstab $carpeta/archivos-configuracion/fstab.txt
cp $unidad/etc/passwd $carpeta/archivos-configuracion/passwd.txt
cp $unidad/etc/shadow $carpeta/archivos-configuracion/shadow.txt
cp $unidad/etc/sudoers $carpeta/archivos-configuracion/sudoers.txt
cp $unidad/etc/sudoers.d $carpeta/archivos-configuracion/sudoers.d.txt
cp $unidad/etc/group $carpeta/archivos-configuracion/group.txt


# Recopilamos informaci�n del sistema de archivos

echo "Recopilando informaci�n del sistema de archivos..."
mkdir $carpeta/sitema-archivos
ls -la $unidad/home/$usuario/home > $carpeta/sitema-archivos/usuarios.txt
find $unidad/home/$usuario -type f -name "*.log" -exec cp {} $carpeta/sitema-archivos/logs.txt \;
cat $unidad/etc/lsb-release > $carpeta/sitema-archivos/version.txt
cat $unidad/hostname > $carpeta/sistema-archivos/hostanme.txt



# Recuperamos archivos eliminados
echo "Recuperando archivos eliminados..."
mkdir $carpeta/archivos-eliminados
sudo foremost -t all -i $unidad/media/$usuario -o $carpeta/archivos-eliminados


# Recuperamos contrase�as
echo "Recuperando contrase�as..."
sudo unshadow $unidad/media/$usuario/etc/passwd $unidad/home/$usuario/etc/shadow > $carpeta/passwd-shadow.txt
# Descifrar contrase�as con John the Ripper
john --wordlist=/usr/share/wordlists/rockyou.tx $carpeta/passwd-shadow.txt

sudo john --wordlist=/usr/share/wordlists/rockyou.txt $unidad/home/$usuario/.ssh/authorized_keys
sudo john --wordlist=/usr/share/wordlists/rockyou.txt $unidad/var/lib/mysql/mysql/user.MYD
sudo john --wordlist=/usr/share/wordlists/rockyou.txt $unidad/var/lib/mysql/mysql/db.MYD 

# Recuperamos informaci�n de red
echo "Recuperando informaci�n de red..."
mkdir $carpeta/red
cat $unidad/etc/network/interfaces > $carpeta/interfaces.txt
cat $unidad/etc/sysconfig/network-scripts > $carpeta/red/network_scripts.txt
cat $unidad/etc/hosts > $carpeta/red/hosts.txt
cat $unidad/etc/resolv.conf > $carpeta/red/dns.txt
cat $unidad/etc/nsswitch.conf > $carpeta/red/orden_dns.txt
cat $unidad/var/lib/NetworkManager > $carpeta/red/dhcp.txt
cat $unidad/var/lib/dhclient >>  $carpeta/red/dhcp.txt
cat $unidad/var/lib/dhcp >>  $carpeta/red/dhcp.txt

#Fecha instalacion aproximada
echo "Recuperando informaci�n de red..."
mkdir $carpeta/instalacion
stat -c %w $unidad/lost+found  > /$carpeta/instalacion/instalacion.txt
sudo debugfs -R 'stat /lost+found' /dev/sda1 >> /$carpeta/instalacion/instalacion.txt
head $unidad/var/log/installer/syslog >>  /$carpeta/instalacion/instalacion.txt
cat $unidad/etc/localtime  >>  /$carpeta/instalacion/zonahoraria.txt

# Historial de comandos
echo "Historial de comandos ..."
mkdir $carpeta/historial-comandos
find $unidad/home -name ".bash_history" -exec cp --parents {} "$carpeta/historial-comandos/historial_comandos.txt" \;



# Archivos de configuraci�n
echo "Archivos de configuracion..."
mkdir $carpeta/historial-configuracion
find /mnt/image/etc -type f -name "*.conf" -o -name "*.cfg" -exec cp --parents {} "$carpeta/historial-configuracion/historial_configuracion.txt" \;

# Cron jobs
echo "Jobs..."
mkdir $carpeta/historial-cron
find $unidad/etc/cron* -type f -exec cp --parents {} "$carpeta/historial-cron/cron.txt" \;

# Servicios y demonios
echo "Servicios y demonios..."
mkdir $carpeta/services-demons
find $unidad/etc/systemd/system -type f -name "*.service" -exec cp --parents {} "$carpeta/services/services.txt-demons" \;

# Timestamp ficheros
echo "Timestamp ficheros......"
mkdir $carpeta/timestamp-ficheros


find $unidad/home -newer $unidad/ -printf "%p, %A+,%T+,%C+\n" > $carpeta/timestamp-ficheros/timestam.txt

#SSH
echo "SSH..."
mkdir $carpeta/ssh
cp $unidad/home/$usuario/.ssh/known_hosts  $carpeta/ssh/known_hosts

cp $unidad/home/$usuario/.ssh/config  $carpeta/ssh/config
