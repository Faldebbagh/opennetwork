#!/bin/bash
set -e
#set -o pipefail
	clear
	echo ################################################
	echo            ---==  OpenNetwork  ==---
	echo ################################################
	echo
	echo             Projekt Teilnehmer:
	echo             Jonas, Firas, Tim R.
	echo
	echo ________________________________________________
path="/etc/opennetwork"
info="./info"
info_ende="/etc/opennetwork/info"
installation="[I] - Wollen Sie OpenNetwork installieren ?"
verwalten="[V] - Wollen Sie Ihre OpenNetwork Verwalten ?"
deinstallieren="[D] - Wollen sie OpenNetwork deinstallieren ?"
readme="[R] - info über Opennetwork lessen !"
benden="[E] - Exit oder Beanden !"

#Installation starten
installation_start(){
	sudo bash 'installation/install.sh'
}

#Verwaltung starten:
verwalten_start(){
	sudo bash verwaltung/verwaltung.sh
}

#Deinstallation starten
deinstall_start(){
	sudo bash 'deinstall.sh'
}
#Überprüfen, ob OpenNetwork bereits installiert ist:
if [ -f $info_ende ];then
	#Mneü anzeigen wenn OpenNetwork installiert ist:
	while true;
	do
	clear
	#echo $test
	#echo $anz
	echo "Sie haben bereits eine Erfolgreiche OpenNetwork Installation."
	echo $verwalten
	echo $deinstallieren
	echo $readme
	echo $benden
	read benutzer_auswahl
	case $benutzer_auswahl in
	[vV])
	echo "Verwaltung wird gestartet"
	#sudo bash verwaltung.sh
	verwalten_start
	clear
	;;
	[dD])
	echo "Deinstallation wird gestartet"
	bash deinstall.sh
	exit 0
	;;
	[rR])
	clear
	cat $info_ende
	;;
	[eE])
	clear
	exit 0
	;;
	*)
	esac
	done
else
	#Menü anzeigen wenn OpenNetwork nicht installiert ist.
        while true;
        do
	echo $test
	echo $anz
	echo "Sie haben OpenNetwork noch nicht installiert."
	echo $installation
	echo $readme
	echo $benden
	read benutzer_auswahl
        case $benutzer_auswahl in
	[iI])
	installation_start
	;;
	[rR])
	clear
	cat $info_ende
	read -p
	sleep 3
	clear
	;;
        [eE])
        clear
        exit 0
        ;;
        *)
        esac
        done

fi
