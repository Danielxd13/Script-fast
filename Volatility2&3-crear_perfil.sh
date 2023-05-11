#!/bin/bash

#Pasos para isntalar volatility 2.6

sudo apt update &&

sudo apt install -y build-essential git libdistorm3-dev yara libraw1394-11 libcapstone-dev tzdata &&

sudo apt install -y python2.7 python2.7-dev libpython2.7-dev curl &&

curl https://bootstrap.pypa.io/pip/2.7/get-pip.py --output get-pip.py &&

sudo python2.7 get-pip.py &&

sudo python2.7 -m pip install -U setuptools wheel &&

python2.7 -m pip install -U distorm3 yara pycrypto pillow openpyxl ujson pytz ipython capstone &&

sudo python2.7 -m pip install yara &&

sudo ln -s /usr/local/lib/python2.7/dist-packages/usr/lib/libyara.so /usr/lib/libyara.so 



#Instalacción volatility 3



git clone https://github.com/volatilityfoundation/volatility3.git &&

cd volatility3 &&

python3 vol.py --help && 

cd ..  



#Instalacción volatilty 2.6



git clone https://github.com/volatilityfoundation/volatility.git &&

cd volatility &&

python2.7 vol.py --help &&

cd .. 







#Crear perfil



sudo apt install linux-image-$(uname -r) linux-headers-$(uname -r) &&

sudo apt install dwarfdump &&

cd volatility/tools/linux/ &&

echo 'MODULE_LICENSE("GPL");' >> module.c &&
# || nano module.c  || añadir al final --> MODULE_LICENSE("GPL");

make &&

## con este comando es que creamos perfil que es el que se pasara a nuestra maquina forense para administrarlo y porder utilizarlo
sudo zip $(lsb_release -i -s)_$(uname -r)_profile.zip ./module.dwarf /boot/System.map-$(uname -r) &&
# || sudo zip volatility/plugins/overlays/linux/$(lsb_release -si)_$(uname -r)_profile.zip tools/linux/module.dwarf /boot/System.map-$(uname -r)

## ~/volatility/tools/linux/
mv Ubuntu_$(uname -r)_profile.zip ../../volatility/plugins/overlays/linux/ &&
cd ../../ &&
# || python2.7 vol.py --info | grep Ubuntu
sudo python2.7 vol.py --info | grep Ubuntu 
## comprobacion de la imagen
## python2.7 vol.py --profile=LinuxUbuntu"version generado" -f "volcado".mem linux_banner

