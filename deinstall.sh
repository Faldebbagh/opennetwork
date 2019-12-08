#alle Software Pakete deinstallieren:
sudo apt autoclean dnsmasq  -y && apt remove --purge dnsmasq -y
sudo apt autoclean dhcpcd  -y && apt remove --purge dhcpcd -y
sudo apt autoclean hostapd  -y && apt  remove --purge  hostapd -y && apt autoremove -y

#Überprüfen ob die DHCP Config Datei exestiert:
if [ -f /etc/dhcpcd.conf ];then
	#Wenn ja: Config Datei Löschen.
	rm /etc/dhcpcd.conf
fi

#Überprüfen ob die DNS Config Datei exestiert:
if [ -f /etc/dnsmasq.conf ];then
	#Wenn ja: Config Datei Löschen.
	rm /etc/dnsmasq.conf
fi

# Wenn Interfaces Einstellung exestiert, dann die alte Interfaces Datei wiederherstellen.
if [ -f /etc/network/interfaces ];then
	rm /etc/network/interfaces
	mv /etc/network/interfaces.old /etc/network/interfaces
fi

#Überprüfen ob die hostapd Config Datei exestiert:
if [ -f /etc/hostapd/hostapd.conf ];then
	#Wenn ja: Config Datei Löschen.
	rm -r /etc/hostapd
fi

forward="net.ipv4.ip_forward=1"
forward_file="/etc/sysctl.conf"
firewall="rules.sh"
firewall_file="/etc/crontab"

#Forwarding Einstellungen zurücksetzten
if grep -q "$forward" "$forward_file"; then
   sudo sed -i /$forward/g  /etc/sysctl.conf
fi

#Firewall Einstellungen löschen
if [ -f /etc/init.d/rules.sh ];then
	rm /etc/init.d/rules.sh
	#Firewall Service löschen
	sudo update-rc.d -f Firewall.sh remove
 	if grep -q "$firewall" "$firewall_file"; then
   	sudo sed -i /$firewall/g  /etc/crontab
	fi
	echo "iptables Einstellungen löschen..."
	sleep 1
	iptables -F
	iptables -X
	iptables -t nat -F
	iptables -t nat -X
	iptables -t mangle -F
	iptables -t mangle -X
	iptables -P INPUT ACCEPT
	iptables -P FORWARD ACCEPT
	iptables -P OUTPUT ACCEPT
fi
# Projektdaten löschen
rm -r /etc/opennetwork
