if [ ! -f "/etc/opennetwork/weblist" ];then
echo >> /etc/opennetwork/weblist
fi
if [ ! -f "/etc/opennetwork/iplist" ];then
echo >> /etc/opennetwork/iplist
fi
if [ ! -f  "/etc/opennetwork/maclist" ];then
echo >> /etc/opennetwork/maclist
fi

hostapd="/etc/hostapd/hostapd.conf"
ip_list="/etc/opennetwork/iplist"
mac_list="/etc/opennetwork/maclist"
web_list="/etc/opennetwork/weblist"
wlan_auschalten(){
        sudo systemctl daemon-reload
        sudo service hostapd stop
        sudo systemctl stop hostapd
        messeg="Wlan wurde ausgeschaltet"
	echo "<script type='text/javascript'>alert('$messeg');</script>";
	rm /var/lib/misc/dnsmasq.leases
}
wlan_anschalten(){
        sudo systemctl start hostapd
        sudo systemctl daemon-reload
        sudo service hostapd start
	echo "" > /var/lib/misc/dnsmasq.leases
	messeg="Wlan Wurde Angeschaltet"
	echo "<script type='text/javascript'>alert('$messeg');</script>";
}
devices(){
	rm /etc/opennetwork/device.log
	service dnsmasq restart
	sleep 1
	cat /etc/opennetwork/device.log
	}
wlan_change(){
	sed -i '/ssid/d'  $hostapd
        echo "ssid=$wlan_name" >> $hostapd
	sed -i '/wpa_passphrase/d' $hostapd
        echo "wpa_passphrase=$wlan_password" >> $hostapd
	service hostapd restart
	messeg="Ihre wlan Name und Password wurde geändert"
	echo "<script type='text/javascript'>alert($messeg);</script>";
}
w_info(){
        wlan_name=`sudo cat $hostapd | grep "ssid=" | sed  s/ssid=//`
        wlan_password=`sudo cat $hostapd | grep "wpa_passphrase=" | sed  s/wpa_passphrase=//`
        echo "Ihre Wlan Name : $wlan_name"
	echo "Ihre Wlan Password : $wlan_password "
	}

web_liste(){
        messeg=`sudo cat /etc/opennetwork/weblist`
	echo $messeg
        }

ip_liste(){
        cat /etc/opennetwork/iplist
        }

mac_liste(){
        cat /etc/opennetwork/maclist
        }
ip_sperr(){
        ip_abfrage=`grep -q  $ip $ip_list || echo "T"`
        case $ip_abfrage in
        [tT])
        echo "$ip" >> /etc/opennetwork/iplist
        messeg="Die IP Adresse [$ip]  wurde gesperrt"
	echo "<script type='text/javascript'>alert('$messeg');</script>";
        ;;
        *)
        messeg="IpAdresse [$ip] ist schon gesperrt"
	echo "<script type='text/javascript'>alert('$messeg');</script>";
        esac
}
ip_entsperr(){
	ip_abfrage=`grep -q  $ip $ip_list || echo "T"`
        case $ip_abfrage in
	[tT])
        messeg="IpAdresse [$ip] ist nicht gesperrt"
        echo "<script type='text/javascript'>alert('$messeg');</script>";
	;;
	*)
        sudo sed -i /$ip/d $ip_list
        messeg="Die IP-Adresse [$ip] wurde aus der Liste enfernt!"
        echo "<script type='text/javascript'>alert('$messeg');</script>";
        esac
}
mac_sperr(){
        mac_abfrage=`grep -q  $mac $mac_list || echo "T"`
        case $mac_abfrage in
        [tT])
        echo "$mac || $mac_user" >> /etc/opennetwork/maclist
        messeg="Die MAC Adresse [$mac] wurde gesperrt"
	echo "<script type='text/javascript'>alert('$messeg');</script>";
        ;;
        *)
        messeg=" Die MAC Adresse [$mac] ist schon gesperrt"
	echo "<script type='text/javascript'>alert('$messeg');</script>";
        esac
}

mac_entsperr(){
        mac_abfrage=`grep -q  $mac $mac_list || echo "T"`
        case $mac_abfrage in
        [tT])
        messeg="Die Mac-Adresse [$mac] ist nicht gesperrt"
        echo "<script type='text/javascript'>alert('$messeg');</script>";
        ;;
	*)
        sudo sed -i /$mac/d $mac_list
        messeg="Die mac-Adresse [$mac] wurde aus der Liste enfernt!"
        echo "<script type='text/javascript'>alert('$messeg');</script>";
        esac
}
web_sperr(){
        web_abfrage=`grep -q  $web $web_list || echo "T"`
        case $web_abfrage in
        [tT])
        echo "$web" >> /etc/opennetwork/weblist
        messeg="Die web Adresse [$web] wurde gesperrt"
        echo "<script type='text/javascript'>alert('$messeg');</script>";
        ;;
        *)
        messeg=" Die web Adresse [$web] ist schon gesperrt"
        echo "<script type='text/javascript'>alert('$messeg');</script>";
        esac
}
web_entsperr(){
        web_abfrage=`grep -q  $web $web_list || echo "T"`
        case $web_abfrage in
        [tT])
        messeg="Die Web-Adresse [$web] ist nicht gesperrt"
        echo "<script type='text/javascript'>alert('$messeg');</script>";
        ;;
        *)
        sudo sed -i /$web/d $web_list
        messeg="Die Web-Adresse [$web] wurde aus der Liste enfernt!"
        echo "<script type='text/javascript'>alert('$messeg');</script>";
        esac
}
system_status(){
fragse="systemctl is-active --quiet $serv_name"
if  $fragse == 1 ;then
echo  ist Aktive - Dinst name $serv_name
else
echo ist Nicht Aktive oder ist im Ruhe stand - Dinst name : $serv_name
fi
}
status(){
        d=`date +%Y-%m-%d-%H-%M`
        serv_name="hostapd"
        echo $d "WLAN - status :" && system_status $serv_name
        serv_name="dnsmasq"
        echo $d "DHCP - status" && system_status $serv_name
        serv_name="rules.sh"
        echo $d "Firewall - status" && service $serv_name restart && system_status $serv_name
}

php_install_auto(){
 sudo bash '/etc/opennetwork/installation/install.sh' auto
}

php_install_conf(){
sudo bash '/etc/opennetwork/installation/install.sh' confing
}
zurck(){
	rm $ip_list
        rm $web_list
        rm $mac_list
        sudo service hostapd force-reload
        sudo service rules.sh restart
        sudo service dnsmq restart
}

if [ $# -gt 0 ];then
         case "$1" in
                [aA])
                wlan_auschalten
                ;;
		[bB])
		wlan_anschalten
		;;
		[cC])
		devices
		;;
		[dD])
		wlan_name=$2
		wlan_password=$3
		wlan_change
		;;
		[eE])
		w_info
		;;
                [fF])
                web_liste
                ;;
                [gG])
                ip_liste
                ;;
                [hH])
                mac_liste
                ;;
                [sS])
		ip=$2
                ip_sperr
                ;;
                [nN])
                ip=$2
                ip_entsperr
                ;;
                [mM])
                mac=$2
		mac_user=$3
                mac_sperr
                ;;
                [vV])
                mac=$2
                mac_entsperr
                ;;
                [wW])
                web=$2
                web_sperr
		;;
	        [yY])
                web=$2
                web_entsperr
                ;;
		[tT])
		status
                ;;
                [xX])
                php_install_auto
                ;;
                [zZ])
                #php_install_conf
                echo "Hallo Hallo"
                valeu=()
                for var in "$@"
                do
                   valeu+=($var)
                done
                wname="${valeu[1]}"
		            wpassword="${valeu[2]}"
                rpi_ip="${valeu[3]}"
                rpi_mask="${valeu[4]}"
                rpi_dns="${valeu[5]}"
                rpi_gateway="${valeu[6]}"
                eth1_ip="${valeu[7]}"
                eth1_subnet="${valeu[8]}"
                eth1_mask="${valeu[9]}"
                eth1_dhcp="${valeu[10]} ${valeu[11]}"
                wlan0_ip="${valeu[12]}"
                wlan0_subnet="${valeu[13]}"
                wlan0_mask="${valeu[14]}"
                wlan0_dhcp="${valeu[15]} ${valeu[16]}"
                echo "<h1>" $wname $wpassword "</h1>"
                echo "<h1>" $rpi_ip $rpi_mask $rpi_dns "</h1>"
                echo "<h1>" $eth1_ip $eth1_subnet $eth1_mask $eth1_dhcp "</h1>"
                echo "<h1>" $wlan0_ip $wlan0_subnet $wlan0_mask $wlan0_dhcp "</h1>"
                ;;


        *)
            ;;
    esac
    shift
fi
