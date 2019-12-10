confing_wlan_auto(){
###WLAN-AP-Host Konfigurieren
if [ -f /etc/hostapd/hostapd.conf ]; then
  sudo mv /etc/hostapd/hostapd.conf /etc/hostapd/hostapd.conf.old
  echo "Eine alte Einstellung von WLAN-AP-Host wurde erkannt!"
  echo "alte Einstellung wurde als hostapd.conf.old gesichert"
fi
echo "Ihr WLAN wird eigerichtet..."
sudo cat <<EOT >> /etc/hostapd/hostapd.conf

# WLAN-Router-Betrieb

# Schnittstelle und Treiber
interface=wlan0
#driver=nl80211

# WLAN-Konfiguration
ssid=WlanTest
channel=10
hw_mode=g
ieee80211n=1
ieee80211d=1
country_code=DE
wmm_enabled=1
# WLAN-Verschlüsselung
auth_algs=1
wpa=2
wpa_key_mgmt=WPA-PSK
rsn_pairwise=CCMP
wpa_passphrase=Firas-1994
EOT

sleep 4
sudo chmod 600 /etc/hostapd/hostapd.conf
clear
###
echo "<------ WLAN - Daemon im Hintergrund starten ------>"
echo "
RUN_DAEMON=yes
DAEMON_CONF="/etc/hostapd/hostapd.conf"
" >> /etc/default/hostapd

###applying a permissions "mask"
echo "##########applying a permissions mask...##########"
sudo systemctl unmask hostapd
sleep 4
echo "##########starte WLAN - Daemon....########## "
sudo systemctl start hostapd
sleep 4
echo "########## WLAN - Daemon autostart ...##########"
sudo systemctl enable hostapd
sleep 4
clear


}
