#!/bin/bash
mkdir ~/temp_glibc
cd ~/temp_glibc
wget -r --user="anonymous" --password="guest@email.com" ftp://ftp.acc.umu.se/mirror/osmc.tv/osmc/apt/pool/main/g/glibc/ -m
cd ~/temp_glibc/ftp.acc.umu.se/mirror/osmc.tv/osmc/apt/pool/main/g/glibc
sudo dpkg -i *.deb
sudo apt-get install -f
sudo apt-get install python3-crypto python3-pycryptodome python3-pip
sudo systemctl stop mediacenter
sudo sed  -i 's+/var/run/lirc/lircd $KODI+/var/run/lirc/lircd LIBC_WIDEVINE_PATCHLEVEL=1 $KODI+g' /usr/bin/mediacenter
sudo systemctl start mediacenter
rm -rf ~/temp_glibc
