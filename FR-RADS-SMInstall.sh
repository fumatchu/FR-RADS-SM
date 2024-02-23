#!/bin/sh
#FR-RADS-SMINstall.sh
#This script installs a set of scripts for FreeRADIUS Management

if [ "$majoros" = "9" ]; then
    echo ${red}"Sorry, but this installer only works on Rocky 9.X ${textreset}"
    echo "Please upgrade to ${green}Rocky 9.x${textreset}"
    echo "Exiting the installer..."
    exit
else
    echo " "
fi

#Checking for user permissions
if [ "$user" = "root" ]; then
    echo ${red}"This program must be run as root ${textreset}"
    echo "Exiting"
    exit
else
    echo " "
fi


cat <<EOF
${GREEN}Installing Server Management${TEXTRESET}
This Installer will provide a set of scripts wrapped in a dialog GUI
You will be able to manage components of FreeRADIUS and services with it


The installer will continue shortly
EOF


sleep 5
dnf -y install dialog nano htop iptraf-ng mc
#If SM exists, delete it
rm  -r -f /root/.servman
rm -r -f /usr/bin/server-manager
sed -i '/usr/bin/server-manager/d' /root/.bash_profile
dnf -y install dialog nano htop iptraf-ng mc
cd /root/FR-RADS-SMInstaller
mkdir /root/.servman
mv -v -f FRM* /root/.servman
mv -v -f ./SERVMan /root/.servman
mv -v -f ./TOOLMan /root/.servman
mv -v -f SYSMan /root/.servman
mv -v -f ServerManager/ /root/.servman
mv -v -f ./SystemManager/ /root/.servman
mv -v -f ./welcome.readme /root/.servman
chmod 700 ./server-manager
mv -v -f server-manager /usr/bin/
chmod 700 -R /root/.servman
echo "/usr/bin/server-manager" >>/root/.bash_profile
rm -r -f /root/FR-RADS*
pkill dialog 
/usr/bin/server-manager

