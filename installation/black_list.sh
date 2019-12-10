APACHE_LOG_DIR="/var/log/apache2"
webinhalt="
<VirtualHost *:80>
      ServerAdmin webmaster@localhost
      DocumentRoot /var/www/html
      ErrorLog ${APACHE_LOG_DIR}/error.log
      CustomLog ${APACHE_LOG_DIR}/access.log combined
  <Directory "/var/www/html">
      AuthType Basic
      AuthName "Restricted Content"
      AuthUserFile /etc/apache2/.htpasswd
      Require valid-user
  </Directory>
  </VirtualHost>
  "
htpasswd='opennetwork:$apr1$jL8ouGRt$uZrBDXzE0lp/b.CpbY.Q2/'
web_panel(){
    mv /var/www/html /var/www/htmlold
    echo "Verwaltung Website Wird Confugrit"
    cp -r installation/html/ /var/www
    sudo cat <<EOT >> /etc/apache2/sites-enabled/000-default.conf
    $webinhalt
EOT
    sleep 2
    echo "Benutzer für die verwaltung seite wird eingerechtet"
    echo $htpasswd > /etc/apache2/.htpasswd
}

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
