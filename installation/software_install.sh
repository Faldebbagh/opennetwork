software_install(){
echo "Update wird installiert..."
sudo apt update -y
sudo apt upgrade -y
sleep 1
clear
echo "Updates und Upgrades sind fertig, jetzt installieren wir alle benötigeten Programme"
sleep 1
clear
echo "Installiere DNSMASQ"
echo "Domain Name System-Weiterleitung, Dynamic Host Configuration Protocol-Server, Router Advertisement "
#sudo SECURE_MYSQL=$(expect -c "
#set timeout 2
#spawn mysql_secure_installation
#expect \"Enter current password for root (enter for none):\"
#send \"$MYSQL\r\"

sudo apt install dnsmasq -y
sleep 1
clear
echo "Installiere hostapd"
echo "_______linux Hotspot_________"
echo "Bitte warten........"
sudo apt install hostapd -y
sleep 1
clear
echo "Installiere DHCP server "
echo "_______ISC DHCP SERVER_________"
echo "Bitte warten...................."
sudo apt install  isc-dhcp-server -y
echo "Installiere apache2 Web-Servie\nfür das Webpanel"
sudo apt install apache2 -y
sleep 1
echo "Installiere PHP7"
sudo apt install php -y
clear
echo "Jetzt wird überprufen ob Alle benötigeten Programme installiert wurde"
sleep 3
clear
software_chek(){
result=`dpkg -s $software_name | grep 'Status: install ok installed' | echo 1`
if [ $result == "1" ]; then
  echo OK !
  else
  echo FAIL !!!!
  echo "Der Paket $software_name waurde nicht Rechtig installiert"
  echo "Bitte kontroliren Sie mit 'journal -xe'"
  exit
fi
}
echo "chek if DNSMASQ _name istalliert wurde !"
software_name="dnsmasq"
software_chek
echo "chek if hostapd istalliert wurde !"
software_name="hostapd"
software_chek $software_name
echo "chek if isc-dhcp-Server istalliert wurde !"
software_name="isc-dhcp-server"
software_chek $software_name
echo "chek if apache2 istalliert wurde !"
software_name="apache2"
software_chek $software_name
echo "chek if PHP istalliert wurde !"
software_name="php"
software_chek $software_name
echo "chek if FIRAS_test  HAHA istalliert wurde !"
software_name="FIRAS_TEST"
software_chek $software_name
echo "Alle benötigeten Programme sind erfolgreich installiert"
}

return 0
