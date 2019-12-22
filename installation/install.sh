#!/bin/bash
#Funktionen/Methoden von andere Scripte importieren:
source ./installation/black_list.sh
source ./installation/php_install.sh
source /etc/opennetwork/installation/confing_dns_dhcp.sh
source /etc/opennetwork/installation/software_install.sh
source /etc/opennetwork/installation/confing_wlan.sh
source /etc/opennetwork/installation/confing_wlan_auto.sh
source /etc/opennetwork/installation/routing.sh
software_chek(){
if [ $(dpkg-query -W -f='${Status}' "$software_name" 2>/dev/null | grep -c "ok installed") -ge 1 ];
then
        echo OK
else
        echo FAIL !!!!
        echo "Der Paket $software_name waurde nicht Rechtig installiert"
        exit
fi

}
####### Version 3
if [ "$1" == "auto" ]
  then

	benutzer_auswahl="Y"
	benutzer_angabe="Y"
	benutzer_install_art="W"
	echo "chek if DNSMASQ _name istalliert wurde !"  "<p></p>"
	software_name="dnsmasq"
	software_chek
	echo "chek if hostapd istalliert wurde !"  "<p></p>"
	software_name="hostapd"
	software_chek $software_name
	echo "chek if isc-dhcp-Server istalliert wurde !"  "<p></p>"
	software_name="isc-dhcp-server"
	software_chek $software_name
	echo "chek if apache2 istalliert wurde !"  "<p></p>"
	software_name="apache2"
	software_chek $software_name
	echo "chek if PHP istalliert wurde !"  "<p></p>"
	software_name="php"
	software_chek $software_name
	echo "chek if FIRAS_test  HAHA istalliert wurde !"  "<p></p>"
	software_name="FIRAS_TEST"
	software_chek $software_name
	echo "Alle benötigeten Programme sind erfolgreich installiert" "<p></p>"
	echo "<p></p>"
  	echo " Installiere: DNS und DHCP... " "<p></p>" && sleep 3
  	confing_dns_dhcp
  	echo " Installiere: WLAN und DHCP... " "<p></p>" && sleep 3
  	confing_wlan_auto
  	echo " Installiere: Routing...""<p></p>"
  	routing
  	messeg="Die Installation wurde erfolgreich abgeschlossen"
  	echo "<script type='text/javascript'>alert('$messeg');</script>";
	exit 5
fi
if [ "$1" == "confing" ]
  then
	benutzer_auswahl="Y"
	benutzer_angabe="N"
  benutzer_install_art="W"
  software_install
  confing_static
exit 5
fi
confing_art(){
	clear
        echo "wollen Sie dass Ihre RPI automatische Einstellungen vorgenommen [Y/N]"
        echo "RPI           ||  IP : DHCP - Auto    "
        echo "wlan          ||  Ip : 192.168.1.1/24 "   "DHCP 192.168.1.100 - 192.168.1.254"
        echo "Eth1          ||  IP : 192.168.2.1/24 "   "DHCP 192.168.2.100 - 192.168.2.254"
	echo "Wlan Name: OpenNwtwork     Wlan kanal : 10       Wlan Kenntwort : 4EMT7E9CPP "
	read benutzer_angabe
	}
clear
################################# V3 Ende
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
echo Wollen Sie die installation per Web Interface starten? [W]
	read benutzer_auswahl
	case $benutzer_auswahl in
	[yY])
  benutzer_install_art="N"
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
	[wW])
	install_start
	;;
	*)
	clear
	esac
exit  0
fi
