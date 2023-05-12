#!/bin/bash

# Actualizar la lista de paquetes
sudo apt-get update

# Instalar dependencias necesarias para compilar LiME
sudo apt-get install -y git build-essential linux-headers-$(uname -r)

# Clonar el repositorio de LiME desde GitHub
git clone https://github.com/504ensicsLabs/LiME.git

# Cambiar al directorio de LiME
cd LiME/src

# Compilar el módulo de LiME (lime-ko)
make

# Cargar el módulo de LiME y extraer la memoria RAM a un archivo
# Cambia 'output.lime' por el nombre del archivo que desees
sudo insmod ./lime-$(uname -r).ko "path=output.lime format=lime"

# Descargar y extraer Volatility, una herramienta de análisis de memoria
wget https://github.com/volatilityfoundation/volatility/archive/2.6.1.tar.gz
tar xf 2.6.1.tar.gz

# Instalar las dependencias de Volatility
sudo apt-get install -y python python-pip
sudo pip install -r volatility-2.6.1/requirements.txt

# Ejecutar Volatility en el archivo de memoria extraído para obtener información básica del sistema
python volatility-2.6.1/vol.py -f output.lime --profile=LinuxUbuntu21046x64 linux_banner

# Remover el módulo de LiME
sudo rmmod lime

# Cambiar al directorio principal y mostrar un mensaje de finalización
cd ../..
echo "Adquisición de memoria completada y almacenada en output.lime"