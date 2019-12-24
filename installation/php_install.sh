install_start(){
  red=`tput setaf 1`
  green=`tput setaf 2`
  reset=`tput sgr0`
  echo vorbereitung auf webinterface install
  echo Bitte warten !!!!!!!!!
  echo Installiere apache2 Web-Servie\nfür das Webpanel
#  sudo apt install apache2 -y
  sleep 1
  echo Installiere PHP7
#  sudo apt install php -y
  clear
  cp -r ./installation/html  /var/www/html
 	if [ -d "/etc/opennetwork" ];then
	  cp -r ./ /etc/opennetwork
	else
	mkdir /etc/opennetwork
	cp -r ./ /etc/opennetwork
  	fi
	sleep 1
	software_chek(){
	if [ $(dpkg-query -W -f='${Status}' "$software_name" 2>/dev/null | grep -c "ok installed") -ge 1 ];
	then
         echo OK !!!!
	else
        echo Fall !!!!
        echo Der paket $software_name wurde nicht rechtig installiert
	exit

	fi

	}

	fi
	}
  echo "chek if apache2 istalliert wurde !"
  software_name="apache2"
  software_chek
  echo "chek if PHP istalliert wurde !"
  software_name="php"
  software_chek

	ip=$(ip addr show eth0 | grep "inet\b" | awk '{print $2}' | cut -d/ -f1)
	 while true
	     do
	      if [ -f "/etc/opennetwork/install_php_protokoll.log" ];then
	           echo "installation wurde abgeschlossen"
             exit
	          else
  	          echo "${green}Gehen Sie bitte google chrome"
  	           echo "http://$ip/install.php${reset} "
                sleep 3
                clear
	      fi
	done
}
