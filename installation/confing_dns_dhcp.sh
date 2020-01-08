meldung_interfces="Wlan - Eth0 - Eth1 konfigurieren"
meldung_DNS="konfigurieren DNS Domain Namensauflösung . . ."
meldung_dhcp="DHCP konfigurieren ........................"
meldung_warten="Bitte Warten ............................"
meldung_fertig="Fertig !"
meldung_dnsmq="DNSMQ konfigurieren ........................"
dnsmq_auto="
dhcp-script=/etc/opennetwork/dns
log-facility=/etc/opennetwork/dnsmasq.log
log-async = 50
no-dhcp-interface=eth0
#dhcp breich für lan Interface
dhcp-range=interface:eth1,192.168.2.100,192.168.2.254,24h
#dhcp breich für wlan Interface
dhcp-range=interface:wlan0,192.168.1.100,192.168.1.254,24h
resolv-file=/etc/resolve.conf
"


interface_auto="auto lo
iface lo inet loopback

auto eth0
iface eth0 inet dhcp

auto eth1
iface eth1 inet static
     address 192.168.2.1
     netmask 255.255.255.0
     gateway 192.168.2.1

auto wlan0
iface wlan0 inet static
     address 192.168.1.1
     netmask 255.255.255.0
     gateway 192.168.1.1
     dns-nameservers 192.168.1.1

"

confing_auto(){
echo $meldung_interfces
echo $meldung_warten
sudo cat <<EOT >> /etc/network/interfaces
$interface_auto
EOT

echo $meldung_fertig
sleep 4
clear
echo $meldung_dhcp
echo $meldung_warten
sleep 4
clear
echo $meldung_fertig
sleep 4
clear
echo $meldung_dnsmq
echo $meldung_warten
sudo cat <<EOT >> /etc/dnsmasq.conf
$dnsmq_auto
EOT
clear
sleep 4
echo $meldung_fertig

}

dhcp_static(){
echo $meldung_dhcp
echo $meldung_warten
sudo cat <<EOT >> /etc/dnsmasq.conf
dhcp-script=/etc/opennetwork/dns
log-facility=/etc/opennetwork/dnsmasq.log
no-dhcp-interface=eth0
#dhcp breich für lan Interface
dhcp-range=interface:eth1,$eth1_dhcp,24h
#dhcp breich für wlan Interface
dhcp-range=interface:wlan0,$wlan1_dhcp,24h
resolv-file=/etc/resolve.conf
EOT
clear
sleep 4
echo $meldung_fertig
}
confing_static(){
echo $meldung_interfces
echo $meldung_warten
sudo cat <<EOT >> /etc/network/interfaces

auto lo
iface lo inet loopback


auto eth0
iface eth1 inet static
     address $rpi_ip
     netmask $rpi_mask
     gateway $rpi_gateway
     dns-nameservers $rpi_dns

auto eth1
iface eth1 inet static
     address $eth1_ip
     netmask $eth1_mask
     gateway $eth1_ip
     dns-nameservers 1$eth1_ip

auto wlan0
iface wlan0 inet static
     address $wlan0_ip
     netmask $wlan0_mask
     gateway $wlan0_ip
     dns-nameservers $wlan0_ip

EOT

clear
echo $meldung_fertig
sleep 4
echo $meldung_dhcp
echo $meldung_warten

sleep 4
clear
echo $meldung_fertig
dhcp_static

	}

benutzer_dns_dhcp(){
	case $benutzer_angabe in
	[yY])
	confing_auto
	;;
	[nN])
	eth0="iface eth0 inet static"
	echo "Bitte geben Sie die IP-Adresse von Ihrem RPi ein"
	read rpi_ip
	echo "Bitte geben Sie die Netzmaske ein"
	read rpi_mask
	echo "Bitte geben Sie das Gateway ein"
	read rpi_gateway
	echo "Bitte geben Sie einen DNS Server ein"
	read rpi_dns
  echo "Bitte geben Sie subnet für eth1 (externer LAN-Adapter) ein"
  echo "subnet beispeil für 192.168.1.0 - 192.168.1.254 ist 255.255.255.0"
  read eth1_subnet
	echo "Bitte geben Sie für eth1 (externer LAN-Adapter) die IP-Adresse ein || \ndie IP-Adresse muss außerhalb des DHCP Breichs sein"
	read eth1_ip
	echo "Bitte geben Sie für eth1 den DHCP breich ein || in form von: 192.168.*.100 192.168.*.254"
	read eth1_dhcp
  echo "Bitte geben Sie die Netzmaske für Eth1 ein"
  read eth1_mask
	echo "Bitte geben Sie die WLAN IP-Adresse ein  || \ndie IP-Adresse muss außerhalb der DHCP Breichs sein"
  read wlan0_ip
  echo "Bitte geben Sie den WLAN DHCP Breich ein || in form von: 192.168.*.100 192.168.*.254 || "
  read wlan0_dhcp
  echo "Bitte geben Sie die Netzmaske für wlan0 ein"
  read wlan0_mask
	confing_static
	;;
	esac
}

confing_dns_dhcp(){
case $benutzer_install_art in
[nN])
  #########################################################
  echo "alte Einstellungen überprüfen: DNS _ DHCP _ Hostapd"
  if [ -f "/etc/network/interfaces" ]; then
    sudo mv /etc/network/interfaces /etc/network/interfaces.old
    echo "alte interfaces Einstellung wurde als Interfaces.old gesichert"
    sleep 4
    clear
  fi
  ########## WLAN-Interface - 2. Eth konfigurieren DHCP -->
  ##alte conf sichern
  if [ -f "/etc/dhcpcd.conf" ]; then
    sudo mv /etc/dhcpcd.conf /etc/dhcpcd.conf.old
    echo "alte dhcpcd.cof wurde erkannt"
    echo "alte Einstellung wurde als dhcpcd.conf.old gesichert"
    sleep 4
    clear
  fi
  ####### in fall alte dhcp server luft
  if [ -f "/etc/dnsmasq.conf" ]; then
    sudo mv /etc/dnsmasq.conf /etc/dnsmasq.conf.old
    echo "DNS Konfiguration wurde erkannt..."
    echo "alte Konfiguration wurde als dnsmasq.conf.old gesichrt..."
    sleep 4
    clear
  fi
  benutzer_dns_dhcp
  sleep 4
  clear
  echo "#####################################################################"
  echo "##DHCP-Server und DNS-Cache prüfen und in Betrieb nehmen (dnsmasq)###"
  echo "#####################################################################"
  echo "##Die Syntaxprüfung sollte mit OK erfolgreich sein.##################"
  echo "#####################################################################"
  dnsmasq --test -C /etc/dnsmasq.conf
  sleep 4
  clear
  echo "<------ DNSMASQ wird neu gestartet: ------>"
  sudo systemctl restart dnsmasq
  sleep 4
  clear
  echo "<------ DNSMASQ beim Systemstart starten: ------>"
  sudo systemctl enable dnsmasq
  sleep 4
  clear
;;
[wW])
echo "alte Einstellungen überprüfen: DNS _ DHCP _ Hostapd" "<p></p>"
if [ -f "/etc/network/interfaces" ]; then
  sudo mv /etc/network/interfaces /etc/network/interfaces.old
  echo "alte interfaces Einstellung wurde als Interfaces.old gesichert" "<p></p>"
  sleep 4
  clear
fi
########## WLAN-Interface - 2. Eth konfigurieren DHCP -->
##alte conf sichern
if [ -f "/etc/dhcpcd.conf" ]; then
  sudo mv /etc/dhcpcd.conf /etc/dhcpcd.conf.old
  echo "alte dhcpcd.cof wurde erkannt" "<p></p>"
  echo "alte Einstellung wurde als dhcpcd.conf.old gesichert" "<p></p>"
  sleep 4
  clear
fi
####### in fall alte dhcp server luft
if [ -f "/etc/dnsmasq.conf" ]; then
  sudo mv /etc/dnsmasq.conf /etc/dnsmasq.conf.old
  echo "DNS Konfiguration wurde erkannt...""<p></p>"
  echo "alte Konfiguration wurde als dnsmasq.conf.old gesichrt...""<p></p>"
  sleep 4
  clear
fi
confing_auto
sleep 4
clear
echo "#####################################################################""<p></p>"
echo "##DHCP-Server und DNS-Cache prüfen und in Betrieb nehmen (dnsmasq)###""<p></p>"
echo "#####################################################################""<p></p>"
echo "##Die Syntaxprüfung sollte mit OK erfolgreich sein.##################""<p></p>"
echo "#####################################################################""<p></p>"
dnsmasq --test -C /etc/dnsmasq.conf
sleep 4
clear
echo "<------ DNSMASQ wird neu gestartet: ------>""<p></p>"
sudo systemctl restart dnsmasq
sleep 4
clear
echo "<------ DNSMASQ beim Systemstart starten: ------>""<p></p>"
sudo systemctl enable dnsmasq
sleep 4
clear
;;
*)
esac
}
