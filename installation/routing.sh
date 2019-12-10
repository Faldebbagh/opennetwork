routing(){
  echo "Routing und NAT für die Internet-Verbindung konfigurieren"
  echo "net.ipv4.ip_forward=1" >> /etc/sysctl.conf
  sleep 4
  clear
  echo "Routing-Informationen werden beim Systemstart geladen"
  if [ -f "/etc/init.d/firewall.sh" ]; then
    echo "alte Routing-Informationen wurde erkannt"
    sudo rm /etc/init.d/rules.sh
    sudo update-rc.d -f rules.sh remove
    sudo rm -r /etc/opennetwork/
    echo "alte Routing-Informationen wurde entferrnt"
  fi
  cp installation/rules /etc/init.d/rules.sh
  chmod +x /etc/init.d/rules.sh
  sudo mkdir /etc/opennetwork
  cp -r  verwaltung /etc/opennetwork
  sudo chmod 755 /etc/opennetwork
  sudo update-rc.d rules.sh defaults
  sudo echo "@reboot root /etc/init.d/rules.sh" >> /etc/crontab
  clear
  echo "Die neu Routing-Information wurden gespeichert"
  sleep 4
}
