#!/bin/bash
debver=$(echo < /etc/debian_version)
if [[ $debver -lt 11 ]]
then
  mkdir ~/temp_glibc
  cd ~/temp_glibc
  wget -r --user="anonymous" --password="guest@email.com" ftp://ftp.acc.umu.se/mirror/osmc.tv/osmc/apt/pool/main/g/glibc/*_armhf.deb -m
  cd ~/temp_glibc/ftp.acc.umu.se/mirror/osmc.tv/osmc/apt/pool/main/g/glibc
  sudo dpkg -i *.deb
  sudo apt-get install -f
  rm -rf ~/temp_glibc  
fi
# Map parameters to coder-friendly names.
Program="kodi"
version="19"
# thanks DavorPerkovac for TypeO in above varible namne

# Program name must be a valid command.
command -v $Program >/dev/null 2>&1 || { echo "Command: $Program not found."; exit 99; }
InstalledVersion=$( "$Program" --version | perl -pe '($_)=/([0-9]+([.][0-9]+)+)/' )
NonDecIV=${InstalledVersion%.*}
if [[ $NonDecIV -lt $version ]]; then
   if [ ! -d /usr/share/doc/python-crypto ]; then
	    sudo apt-get install -q -y python-crypto
   fi
   sudo apt-get install -q -y build-essential python-pip libnss3 libnspr4
   sudo pip install -q -U setuptools
   sudo pip install -q wheel
   sudo pip install -q pycryptodomex
   sudo systemctl stop mediacenter
   sudo sed  -i 's+/var/run/lirc/lircd $KODI+/var/run/lirc/lircd LIBC_WIDEVINE_PATCHLEVEL=1 $KODI+g' /usr/bin/mediacenter
   sudo systemctl start mediacenter
else
   sudo apt-get install python3-crypto python3-pycryptodome python3-pip
fi

