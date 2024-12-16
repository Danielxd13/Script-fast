#!/bin/bash 
## se hizo 5/5/2023
## utilizacion: bash script-install-volatility2-linux.sh, si no te funciona reinicia
sudo rm -r volatility/ ||
sudo apt update &&
# instalacion de librerias y dependencias
# paquete que no se instala capstone-tool, no es necesario pero puede dar problemas al futuro 
sudo apt install -y build-essential &&
sudo apt install -y git &&
sudo apt install -y libdistorm3-dev &&
sudo apt install -y yara &&
sudo apt install -y libraw1394-11 &&
sudo apt install -y libcapstone-dev &&
sudo apt install -y tzdata &&
sudo apt install -y python2.7  &&
sudo apt install -y python2.7-dev &&
sudo apt install -y libpython2.7-dev &&
sudo apt install -y curl &&
curl https://bootstrap.pypa.io/pip/2.7/get-pip.py --output get-pip.py &&
sudo python2.7 get-pip.py &&
sudo python2.7 -m pip install -U setuptools Wheel &&
python2.7 -m pip install -U distorm3 yara pycrypto pillow openpyxl ujson pytz ipython capstone &&
sudo python2.7 -m pip install yara &&
sudo ln -s /usr/local/lib/python2.7/dist-packages/usr/lib/libyara.so /usr/lib/libyara.so &&
udo apt install python2-minimal -y &&
git clone --depth 1 https://github.com/volatilityfoundation/volatility.git &&
python2.7 volatility/vol.py --help  #comprobacion de que funciona
echo "Si te aparecio la ayuda supuestamente es que te funciona"
