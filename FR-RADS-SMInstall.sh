## SMInstall.sh
if [ "$majoros" = "9" ]; then
    echo ${red}"Sorry, but this installer only works on Rocky 9.X ${textreset}"
    echo "Please upgrade to ${green}Rocky 9.x${textreset}"
    echo "Exiting the installer..."
    exit
else
    echo ${green}"Version information matches..Continuing${textreset}"
fi

#Checking for user permissions
if [ "$user" = "root" ]; then
    echo ${red}"This program must be run as root ${textreset}"
    echo "Exiting"
    exit
else
    echo "Running Program"
fi

cat <<EOF
This Installer will provide a GUI Driven menu for interacting with your system.
You can disable it, or not use it at all if you are comfortable with CLI.
However, there are tools built in for diagnotstics on FreeRADIUS and testers to
assist in troubleshooting or validating configurations.


The installer will continue shortly
EOF

sleep 20
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
/usr/bin/server-manager
rm -r -f /root/FR-RADS*
