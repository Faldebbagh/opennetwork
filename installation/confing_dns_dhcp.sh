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
"

dhcp_auto="
# Inform the DHCP server of our hostname for DDNS.
hostname
# Persist interface configuration when dhcpcd exits.
persistent
# Rapid commit support. Safe to enable by default because it requires the equivalent option set on the server to actually work.
option rapid_commit
# A list of options to request from the DHCP server.
option domain_name_servers, domain_name, domain_search, host_name option classless_static_routes
# Most distributions have NTP support.
option ntp_servers
# Respect the network MTU. This is applied to DHCP routes.
option interface_mtu
# A ServerID is required by RFC2131.
require dhcp_server_identifier
# Generate Stable Private IPv6 Addresses instead of hardware based ones
slaac private
# Lan Interface Konf.
interface eth1
static ip_address=192.168.2.1/24
static routers=192.168.2.1
static domain_name_servers=192.168.2.1
#Wlan Interface Konf.
interface wlan0
static ip_address=192.168.1.1/24
static routers=192.168.1.1
static domain_name_servers=192.168.1.1
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
sudo cat <<EOT >> /etc/dhcpcd.conf
$dhcp_auto
EOT
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
     address 192.168.2.1
     netmask 255.255.255.0
     gateway 192.168.2.1
     dns-nameservers 192.168.2.1

auto wlan0
iface wlan0 inet static
     address 192.168.1.1
     netmask 255.255.255.0
     gateway 192.168.1.1
     dns-nameservers 192.168.1.1

EOT

clear
echo $meldung_fertig
sleep 4
echo $meldung_dhcp
echo $meldung_warten
sudo cat <<EOT >> /etc/dhcpcd.conf
# Inform the DHCP server of our hostname for DDNS.
hostname
# Persist interface configuration when dhcpcd exits.
persistent
# Rapid commit support. Safe to enable by default because it requires the equivalent option set on the server to actually work.
option rapid_commit
# A list of options to request from the DHCP server.
option domain_name_servers, domain_name, domain_search, host_name option classless_static_routes
# Most distributions have NTP support.
option ntp_servers
# Respect the network MTU. This is applied to DHCP routes.
option interface_mtu
# A ServerID is required by RFC2131.
require dhcp_server_identifier
# Generate Stable Private IPv6 Addresses instead of hardware based ones
slaac private
# Lan Interface Konf.
interface eth1
static ip_address=$eth1_ip/24
static routers=$eth1_ip
static domain_name_servers=$eth1_ip
#Wlan Interface Konf.
interface wlan0
static ip_address=$wlan1_ip/24
static routers=$wlan1_ip
static domain_name_servers=$wlan1_ip
EOT
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
	echo "Bitte geben Sie für eth1 (externer LAN-Adapter) die IP-Adresse ein || \ndie IP-Adresse muss außerhalb des DHCP Breichs sein"
	read eth1_ip
	echo "Bitte geben Sie für eth1 den DHCP breich ein || in form von: 192.168.*.100,192.168.*.254"
	read eth1_dhcp
	echo "Bitte geben Sie die WLAN IP-Adresse ein  || \ndie IP-Adresse muss außerhalb der DHCP Breichs sein"
  read wlan1_ip
  echo "Bitte geben Sie den WLAN DHCP Breich ein || in form von: 192.168.*.100,192.168.*.254 || "
  read wlan1_dhcp
	confing_static
	;;
	esac
}

confing_dns_dhcp(){
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
}
