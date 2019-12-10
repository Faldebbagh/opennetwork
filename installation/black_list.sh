black_list(){
  while true
    do
      read -r -p "Möchten Sie weitere Webseiten sperren? [Y/n] " input

      case $input in
      [yY][eE][sS]|[yY])
      echo "Bitte geben Sie eine Webseite ein"
      read web
      ip=`nslookup $web | grep "Address: " | grep -Eo '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}'`
      echo "$ip" >> /etc/opennetwork/iplist
      echo "$web" >> /etc/opennetwork/weblist
      clear
      ;;
      [nN][oO]|[nN])
      echo "Sie Können zu jeder Zeit weitere Webseiten sperren"
      echo "starten Sie /etc/opennetwork/blacklist.sh"
      sleep 2
      echo "Ihre OpenNetwork installation war erfolgreich, Ihr RPi wird in kürze neugestartet"
      sleep 3
      sudo reboot
      ;;
      *)
      echo "Falsche Eingabe "
      ;;
      esac
    done
}
