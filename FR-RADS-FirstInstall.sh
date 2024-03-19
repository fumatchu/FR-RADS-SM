#!/bin/sh
#FR-RADS-SMINstall.sh
#This script installs a set of scripts for FreeRADIUS Management
TEXTRESET=$(tput sgr0)
RED=$(tput setaf 1)
YELLOW=$(tput setaf 3)
GREEN=$(tput setaf 2)
USER=$(whoami)
MAJOROS=$(cat /etc/redhat-release | grep -Eo "[0-9]" | sed '$d')

#Checking for user permissions
if [ "$USER" = "root" ]; then
echo " "
else
  echo ${RED}"This program must be run as root ${TEXTRESET}"
  echo "Exiting"
fi
#Checking for version Information
if [ "$MAJOROS" = "9" ]; then
echo " "
else
  echo ${RED}"Sorry, but this installer only works on Rocky 9.X ${TEXTRESET}"
  echo "Please upgrade to ${GREEN}Rocky 9.x${TEXTRESET}"
  echo "Exiting the installer..."
  exit
fi

cat <<EOF
${GREEN}Installing Server Management${TEXTRESET}
This Installer will provide a set of scripts wrapped in a dialog GUI
You will be able to manage components of FreeRADIUS and services with it
At Anytime from the CLI, type ${YELLOW}server-manager${TEXTRESET}


The installer will continue shortly
EOF


sleep 7
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
cd; cd -
/usr/bin/server-manager
