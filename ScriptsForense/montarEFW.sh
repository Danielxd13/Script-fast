#!/bin/bash

# Reemplaza estas variables con la ruta de tu imagen EWF y el punto de montaje deseado
EWF_IMAGE_PATH="/ruta/a/tu/imagen.ewf"
MOUNT_POINT="/ruta/al/punto/de/montaje"

# Monta la imagen EWF
EWF_MOUNT_TMP="$(mktemp -d)"
sudo ewfmount "$EWF_IMAGE_PATH" "$EWF_MOUNT_TMP"

# Obtiene el dispositivo loop asociado
LOOP_DEVICE=$(sudo losetup --show -f -P "${EWF_MOUNT_TMP}/ewf1")

# Monta el dispositivo loop en el punto de montaje
sudo mkdir -p "$MOUNT_POINT"
sudo mount -o ro "${LOOP_DEVICE}p1" "$MOUNT_POINT"

echo "Imagen EWF montada en $MOUNT_POINT"

# Desmonta la imagen EWF y el dispositivo loop al salir
cleanup() {
    sudo umount "$MOUNT_POINT"
    sudo losetup -d "$LOOP_DEVICE"
    sudo umount "$EWF_MOUNT_TMP"
    rm -r "$EWF_MOUNT_TMP"
}

trap cleanup EXIT

#!/bin/bash

# Verificar si el archivo EFW existe
if [ ! -f "$1" ]; then  
  echo "El archivo $1 no existe."
  exit 1
fi

# Verificar si se ha especificado una ruta de montaje
if [ -z "$2" ]; then
  echo "Debe especificar una ruta de montaje."
  exit 1
fi

# Crear un dispositivo loopback
loop_device=$(sudo losetup -f)
sudo losetup $loop_device $1

# Mostrar el loop creado
echo "El archivo $1 ha sido montado en el loop $loop_device"

# Montar el dispositivo loopback sin ejecutar archivos
sudo mount -o ro,noload $loop_device "$2"

# Mostrar el contenido del archivo EFW
ls -la "$2"

# Desmontar el dispositivo loopback
sudo umount "$2"
sudo losetup -d $loop_device



#!/bin/bash

if [ "$#" -ne 2 ]; then
    echo "Uso: $0 <archivo_efw> <directorio_montaje>"
    exit 1
fi

archivo_efw="$1"
directorio_montaje="$2"

# Comprobar si el archivo EFW existe
if [ ! -f "$archivo_efw" ]; then
    echo "Error: El archivo EFW $archivo_efw no existe."
    exit 1
fi

# Comprobar si el directorio de montaje existe
if [ ! -d "$directorio_montaje" ]; then
    echo "Error: El directorio de montaje $directorio_montaje no existe."
    exit 1
fi

# Montar el archivo EFW con losetup
loop_device=$(losetup --show -fP "$archivo_efw")
if [ $? -ne 0 ]; then
    echo "Error: No se pudo montar el archivo EFW con losetup."
    exit 1
fi

echo "Archivo EFW montado en el dispositivo de bucle: $loop_device"

# Montar el contenido del archivo EFW en el directorio de montaje
mount "${loop_device}p1" "$directorio_montaje"
if [ $? -ne 0 ]; then
    echo "Error: No se pudo montar el contenido del archivo EFW en el directorio de montaje."
    losetup -d "$loop_device"
    exit 1
fi

echo "Contenido del archivo EFW montado en: $directorio_montaje"
