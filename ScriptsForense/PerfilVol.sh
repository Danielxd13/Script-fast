#!/bin/bash
#Pasos para isntalar volatility 2.6
sudo apt update
sudo apt install -y build-essential git libdistorm3-dev yara libraw1394-11 libcapstone-dev capstone-tool tzdata
sudo apt install -y python2 python2.7-dev libpython2-dev curl 
curl https://bootstrap.pypa.io/pip/2.7/get-pip.py --output get-pip.py 
sudo python2 get-pip.py 
sudo python2 -m pip install -U setuptools whee
python2 -m pip install -U distorm3 yara pycrypto pillow openpyxl ujson pytz ipython capstone 
sudo python2 -m pip install yara
sudo ln -s /usr/local/lib/python2.7/dist-packages/usr/lib/libyara.so /usr/lib/libyara.so

#Instalacción volatility 3

git clone https://github.com/volatilityfoundation/volatility3.git
cd volatility3
python3 vol.py --help 
cd ..

#Instalacción volatilty 2.6

git clone https://github.com/volatilityfoundation/volatility.git 
cd volatility 
python2.7 vol.py --help
cd ..


#Creación de perfil


sudo apt update && sudo apt upgrade 
sudo apt-get install flex
sudo apt-get install bison
sudo apt install dwarfdump linux-headers-$(uname -r)  
sudo apt install linux-image-$(uname -r) linux-headers-$(uname -r)
cd volatility/tools/linux
MODULE_LICENSE("GPL");
make
sudo zip $(lsb_release -i -s)_$(uname -r)_profile.zip ./module.dwarf /boot/System.map-$(uname -r) 
zip $(lsb_release -i -s)_$(uname -r)_profile.zip ./volatility/tools/linux/module.dwarf /boot/System.map-$(uname -r)



#Solucción probelemas

#Si al hacer make nos da uno de estos problemas: –make[2]: *** [scripts/Makefile.modpost:124: /home/usuario/volatility/tools/linux/Module.symvers] Error 1 –“ERROR: modpost: missing MODULE_LICENSE() in /home/usuario/volatility/tools/linux/module.o” 

#Lo solucionamos con –Abrimos volatility/tools/linux/module.c –Añadimos la siguiente línea al final: •
#Repetimos el make 


#Para que Volatility lo tenga como candidato, moverlo al directorio de plugins apropiado –P. ej.: mv Ubuntu_5.4.0-52-generic_profile.zip volatility/volatility/plugins/overlays/linux/ •También podemos tener los perfiles en otra carpeta y cargarlos bajo demanda con: –--plugins=<RUTA_DIRECTORIO>

#Si todo ha ido bien, deberíamos verlo al ejecutar –python2.7 vol.py --info •Podemos acotar los resultados: –python2.7 vol.py --info | grep Ubuntu •Nótese que el perfil sale con un nombre ligeramente distinto al zip (empieza por Linux) 



#!/bin/bash
git clone https://github.com/volatilityfoundation/volatility.git
cd volatility/tools/linux/ && make
cd ../../../
zip $(lsb_release -i -s)_$(uname -r)_profile.zip ./volatility/tools/linux/module.dwarf /boot/System.map-$(uname -r)
rm -rf ./volatility


 https://github.com/microsoft/avml/releases

cd amvl

sudo chmod +x avml

sudo ./avml /home/ubuntu/volatility/imagen.mem 


python2.7 vol.py --info | grep Ubuntu

git clone https://github.com/Dead-Simple-Scripts/AutoLLR

python2.7 vol.py --profile=LinuxUbuntu_5_15_0-53-generic_profilex64 -f imagen.mem linux_pslist