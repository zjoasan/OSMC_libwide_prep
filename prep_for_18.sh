#!/bin/bash
mkdir ~/temp_glibc
cd ~/temp_glibc
wget -r --user="anonymous" --password="guest@email.com" ftp://ftp.acc.umu.se/mirror/osmc.tv/osmc/apt/pool/main/g/glibc/ -m
cd ~/temp_glibc/ftp.acc.umu.se/mirror/osmc.tv/osmc/apt/pool/main/g/glibc
sudo dpkg -i *.deb
sudo apt-get install -f
sudo apt-get install -q -y build-essential python-pip libnss3 libnspr4 python-crypto
sudo pip install -q -U setuptools
sudo pip install -q wheel
sudo pip install -q pycryptodomex
sudo systemctl stop mediacenter
sudo sed  -i 's+/var/run/lirc/lircd $KODI+/var/run/lirc/lircd LIBC_WIDEVINE_PATCHLEVEL=1 $KODI+g' /usr/bin/mediacenter
sudo systemctl start mediacenter
cd
rm -rf ~/temp_glibc
