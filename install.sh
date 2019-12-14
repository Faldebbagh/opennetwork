#!/bin/bash
#Funktionen/Methoden von andere Scripte importieren:
source ./installation/black_list.sh
source ./installation/confing_dns_dhcp.sh
source ./installation/software_install.sh
source ./installation/confing_wlan.sh
source ./installation/confing_wlan_auto.sh
source ./installation/routing.sh

password=`openssl rand -base64 48 | cut -c1-10`
confing_art(){
        clear
        echo "wollen Sie dass Ihre RPI automatische Einstellungen vorgenommen [Y/N]"
        echo "RPI           ||  IP : DHCP - Auto    "
        echo "wlan          ||  Ip : 192.168.1.1/24 "   "DHCP 192.168.1.100 - 192.168.1.254"
        echo "Eth1          ||  IP : 192.168.2.1/24 "   "DHCP 192.168.2.100 - 192.168.2.254"
        echo "Wlan Name: OpenNwtwork     Wlan kanal : 10      Wlan Kenntwort:$password     "
        read benutzer_angabe
        }
clear


#Erneut abfragen ob die Installation von OpenNetwork erfolgreich war.
#Wenn das der Fall ist: Script starten:
if [ -f /etc/opennetwork/info ];then
clear
echo ---------= OpenNetwork Installation wurde erkannt =-----------------
echo Ihre OpenNetwork Installation wurde erfolgreich erkannt.
echo Wenn Sie OpenNetwork noch mal installieren wollen, dann
echo müssen Sie OpenNetwork vorher nochmal deinstallieren.
sleep 5
clear
exit  0
else
echo ############################################################
echo                  ---== OpenNetwork ==---
echo ############################################################
echo
echo                  Projekt Teilnehmer:
echo                  Jonas, Firas, Tim R.
echo
echo  ___________________________________________________________
echo
#frge ob der benutzer installiern will .
echo Wollen Sie die Installation starten?[Y/N]
	read benutzer_auswahl
	case $benutzer_auswahl in
	[yY])
	confing_art
	echo " Installiere: Software... " && sleep 3
 	software_install
 	echo " Installiere: DNS und DHCP... " && sleep 3
	confing_dns_dhcp
	echo " Installiere: WLAN und DHCP... " && sleep 3
	confing_wlan
	echo " Installiere: Routing..."
	routing
	echo " Installiere: Blacklist..."
	black_list
	;;
	[nN])
	clear
	echo " Installation wurde abgebrochen!"
	sleep 3
	exit 0
	;;
	*)
	clear
	esac
exit  0
fi
