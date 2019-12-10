#!/bin/bash
ip_list="/etc/opennetwork/iplist"
web_list="/etc/opennetwork/weblist"
mac_list="/etc/opennetwork/maclist"
skript_file="/etc/opennetwork/"
wlan_option=""
hostapd="/etc/hostapd/hostapd.conf"
wlan_verwalten(){
while true
do
	echo "1 - WLAN Anschalten "
	echo "2 - WLAN Ausschalten"
	echo "3 - WLAN Name und Passwort anzeigen"
	echo "4 - WLAN Name und Passwort ändern"
	echo "5 - alle verbundenen WLAN Geräte anzeigen"
	echo "R - zurück zum Hauptmenü"
	read benutzer_angabe
	case $benutzer_angabe in
	[1])
	sudo systemctl start hostapd
	sudo systemctl daemon-reload
	sudo service hostapd start
	clear
	;;
	[2])
	sudo systemctl daemon-reload
	sudo service hostapd stop
	sudo systemctl stop hostapd
	clear
	;;
	[3])
	wlan_name=`sudo cat $hostapd | grep "ssid=" | sed  s/ssid=//`
	wlan_password=`sudo cat $hostapd | grep "wpa_passphrase=" | sed  s/wpa_passphrase=//`
	echo "Ihr WLAN Name : $wlan_name "
	echo "Ihr WLAN Passwort : $wlan_password "
	read -p "Weiter mit Enter"
	clear
	;;
	[4])
        echo "Bitte geben Sie den neuen WLAN Namen ein"
        read wlan_name
        sed -i '/ssid/d'  $hostapd
        echo "ssid=$wlan_name" >> $hostapd
        sleep 1
        echo "Bitte geben Sie das neue WLAN Passwort ein"
        read wlan_password
        sed -i '/wpa_passphrase/d' $hostapd
        echo "wpa_passphrase=$wlan_password" >> $hostapd
        sudo service hostapd force-reload
        clear
	;;
	[5])
	clear
	cat /var/lib/misc/dnsmasq.leases | grep "192.168.1"
	read -p "Weiter mit Enter"
	;;
	[rR])
	clear
	return 0
	;;
	*)
esac
done
		}


web_verwalten(){
	while true
do
        clear
        echo "1 - Domain sperren."
        echo "2 - Domain wieder freigeben"
        echo "3 - alle gesperrten Domains anzeigen"
        echo "R - Zurück zum Hauptmenü"
        read  benutzer_Eingabe
        case $benutzer_Eingabe in
        [1])
	clear
	echo  "Geben Sie eine Domain ein"
	read web
	web_abfrage $web
	;;
	[2])
	clear
  	echo  "Geben Sie eine Domain ein"
	read $web
        web_abfrage=`grep -q  $web $web_list || echo "T"`
        case $web_abfrage in
        [tT])
        echo "Die Web-Adresse [$web] ist nicht gesperrt"
        ;;
        *)
        sudo sed -i /$web/d $web_list
        echo "Die Web-Adresse [$web] wurde aus der Liste entfernt"
        esac

	read -p " weiter mit Enter"
	;;
	[3])
	clear
	echo "Domain Liste"
	cat $web_list
	read -p "Weiter mit Enter"
	;;
	[rR])
	clear
	return 0
	;;
esac
done
		}


web_abfrage(){
web_abfrage=`grep -q  $web $web_list || echo "T"`
case $web_abfrage in
        [tT])
	ip=`nslookup $web | grep "Address: " | grep -Eo '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}'`
        echo "$ip" >> /etc/opennetwork/iplist
        echo "$web" >> /etc/opennetwork/weblist
        echo "Die Webseite wurde gesperrt"
        read -p "Weiter mit Enter"
	;;
        *)
        echo "Die Webseite ist schon gesperrt"
	read -p "Weiter mit Enter"
        esac
}
ip_verwalten(){
        while true
do
        clear
        echo "1 - IP-Adresse sperren"
        echo "2 - IP-Adresse wieder freigeben"
        echo "3 - alle gesperrten IP-Adressen anzeigen"
				echo "4 - alle IP-Adressen von verbunden Geräten anzeigen"
        echo "R - Zurück zum Hauptmenü"
        read  benutzer_Eingabe
        case $benutzer_Eingabe in
        [1])
	clear
	echo "Geben Sie eine IP-Adresse ein"
	read ip
	ip_abfrage $ip
	sleep 1
	;;
	[2])
	clear
	echo "Geben Sie eine IP-Adresse ein"
	read ip
	sudo sed -i /$ip/d $ip_list
	echo "Die IP-Adresse [$ip] wurde wieder freigeben!"
	;;
	[3])
	clear
	cat $ip_list
	read -p "Weiter mit Enter"
	;;
	[4])
	clear
	echo "Alle IP-Adressen"
	cat /var/lib/misc/dnsmasq.leases
	read -p "Weiter mit Enter"
	;;
	[rR])
	clear
	return 0
	;;

esac
done
		}

ip_abfrage(){
        ip_abfrage=`grep -q  $ip $ip_list || echo "T"`
        case $ip_abfrage in
        [tT])
        echo "$ip" >> /etc/opennetwork/iplist
        echo "Die IP Adresse [$ip]  wurde gesperrt"
	read -p "weiter mit Enter"
        ;;
        *)
        echo "IP-Adresse [$ip] ist schon gesperrt"
	read -p "weiter mit Enter"
        esac
}
mac_abfrage(){
	mac_abfrage=`grep -q  $mac $mac_list || echo "T"`
        case $mac_abfrage in
        [tT])
        echo "$mac || $mac_user" >> /etc/opennetwork/maclist
        echo "Die MAC-Adresse [$mac] wurde gesperrt"
        read -p "weiter mit Enter"
        ;;
        *)
        echo " Die MAC-Adresse [$mac] ist schon gesperrt"
        read -p "weiter mit Enter"
        esac
}

mac_vervartlung(){
	while true
		do
			clear
			echo "1 - MAC-Adresse sperren"
			echo "2 - MAC-Adresse wieder freigeben"
			echo "3 - alle gesperrten MAC-Adressen anzeigen"
			echo "4 - Alle verbundenen Gräte anzeigen"
			echo "R - Zurück zum Hauptmenü"
			read  benutzer_Eingabe
			case $benutzer_Eingabe in
			[1])
			echo "Bitte geben Sie eine MAC-Adresse ein"
			read mac
			echo "Bitte geben Sie einen Benutzername Für die MAC Adresse an"
			read mac_user
			mac_abfrage $mac
			;;
			[2])
			echo "Bitte geben Sie eine MAC-Adresse ein, die wieder freigeben werden soll"
			read mac
			sudo sed -i /$mac/d $mac_list
			echo "MAC-Adresse wurde wieder freigeben"
			sleep 3
			;;
		 	[3])
			clear
			echo "alle MAC-Adressen anzeigen"
			cat $mac_list
			read -p "Weiter mit Enter"
			;;
			[4])
			clear
			cat /var/lib/misc/dnsmasq.leases
			read -p "Weiter mit Enter"
			;;
			[rR])
			clear
		  return 0
			;;
			*)
			clear
			;;
			esac
		done
}

system_status(){
	fragse="systemctl is-active --quiet $serv_name"
	if $fragse == 1; then
		echo ist Aktive - Dinst name $serv_name
	else
		echo ist Nicht Aktive oder ist im Ruhe stand - Dinst name : $serv_name
	fi
}

system_reload(){
	sudo systemctl daemon-reload
	sudo service dnsmasq restart
	echo "DNSMASQ wurde neu geladen"
	sudo service hostapd restart
	echo "HOSTAPD wurde neu geladen"
	sudo service dhcpcd restart
	echo "DHCP wurde neu geladen"
	sudo service rules restart
	echo "Firewall wurde neu geladen"
}

Firewall_zurck(){
	while true
		do
			echo "Sind Sie sich sicher, dass Sie die Firewall zurücksetzen möchten?"
	    echo "        Y=Zurücksetzten , N=Nein, nicht zurücksetzen."
	    read benutzer_antwort
	    case $benutzer_antwort in
	    [yY])
			echo "Bitte warten..."
	    rm $ip_list
	    rm $web_list
	    rm $mac_list
	    sudo service hostapd force-reload
	    sudo service rules.sh restart
	    sudo service dnsmq restart
	    clear
	    echo "Firewall wurde erfolgreich zurückgesetzt"
			echo "Beim dem nächsten start von dem Skript wird alles wieder hergestellt"
			sleep 2
	    break
	    ;;
	    [nN])
	    return 0
			;;
	    esac
		done
}

#####################################################################################
##Anfag des Skript verlauf
clear
if [ -f "/etc/opennetwork/weblist" ];then
	echo "Web Liste wurde erkannt ......."
	sleep 1
else
	echo >> /etc/opennetwork/weblist
	echo  "Web Liste wurde erzeugt ......."
	sleep 1
fi
if [ -f "/etc/opennetwork/iplist" ];then
	echo "IP Liste wurde erkannt  ......."
	sleep 1
else
	echo >> /etc/opennetwork/iplist
	echo  "IP Liste wurde erzugt  ......."
	sleep 1
fi
if [ -f  "/etc/opennetwork/maclist" ];then
	echo "MAC Liste wurden erkannt ......"
	echo "Das Skript wird gestartet"
	sleep 2
else
	echo >> /etc/opennetwork/maclist
	echo "MAC Liste wurde erzeugt  ......."
	echo "Das Skript wird gestartet......"
	sleep 2
fi

clear
while true
	do
		echo "################################################################################################"
		echo "##                                  OpenNetwork, Verwaltung                                    #"
		echo "##                                                                                             #"
		echo "##                  Sie können Webseiten , IP-Adressen , MAC-Adressen sperren                  #"
		echo "##                            oder alle Listen anzeigen lassen                                 #"
		echo "################################################################################################"
		echo "################################################################################################"
		echo "[1] - WLAN verwalten            "
		echo "[2] - Webseiten verwalten       "
		echo "[3] - IP-Adressen verwalten     "
		echo "[4] - MAC-Adressen verwalten    "
		echo "[5] - System status             "
		echo "[6] - System force-reload       "
		echo "[A] - alle Blacklisten anzeigen "
		echo "[E] - Beenden                   "
		echo "[Z] - Firewall zurücksetzen     "
		read  input
    case $input in
		[1])
		clear
		wlan_verwalten
		;;
    [2])
    web_verwalten
		#echo "$angabe $web_angabe"
		#read web
		#web_abfrage $web
		clear
		;;
	  [3])
		ip_verwalten
		#echo "bitte gebne eine IpAdresse ein"
	        #read ip
		#ip_abfrage $ip
	        #clear
	        ;;
	        [4])
		mac_vervartlung
		clear
		;;
		[5])
		d=`date +%Y-%m-%d-%H-%M`
		serv_name="hostapd"
		echo $d "WLAN - status :" && system_status $serv_name
		serv_name="dnsmasq"
		echo $d "DNSMASQ - status" && system_status $serv_name
		serv_name="dhcpcd"
		echo $d "DHCP - status" && system_status $serv_name
		serv_name="rules"
		echo $d "Firewall - status" && service $serv_name restart && system_status $serv_name
		read -p "weiter mit Enter"
		clear
		;;
		[6])
		system_reload
		;;
	  [eE])
		sudo systemctl daemon-reload
		sudo iptables -F
		sudo service rules.sh restart
		clear
		exit 0
	  ;;
	  [aA])
		clear
		echo "#######################################"
		echo "############Ip Listen##################"
		echo "#######################################"
	  cat /etc/opennetwork/iplist
		read -p "weiter mit Enter"
		clear
		echo "#######################################"
		echo "############Weblisten##################"
		echo "#######################################"
		cat /etc/opennetwork/weblist
		read -p "weiter mit Enter"
		clear
		echo "#######################################"
	  echo "############Mac Adressen###############"
		echo "#######################################"
		cat /etc/opennetwork/maclist
		read -p "weiter mit Enter"
		clear
	  ;;
		[zZ])
	  Firewall_zurck
  	;;
   	*)
	  echo "Falsche Eingabe"
		clear
		;;
	esac
done
