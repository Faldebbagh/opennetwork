<?php
$in=$_POST['install'];
if ($in == "auto"){
$wn=$_POST['wname'];
$wp=$_POST['wpassword'];
$et0_a=$_POST['eth0_a'];
$et0_m=$_POST['eth0_m'];
$et0_d=$_POST['eth0_d'];
$et1_r=$_POST['eth1_r'];
$et1_a=$_POST['eth1_a'];
$et1_sm=$_POST['eth1_sm'];
$et1_d=$_POST['eth1_d'];
$et1_dha=$_POST['eth1_dha'];
$et1_dhe=$_POST['eth1_dhe'];
$wl_r=$_POST['wlan_r'];
$wl_a=$_POST['wlan_a'];
$wl_sm=$_POST['wlan_sm'];
$wl_d=$_POST['wlan_d'];
$wl_dha=$_POST['wlan_dha'];
$wl_dhe=$_POST['wlan_dhe'];
echo "<h3>" . "Ihre Installation Wird mit die Folgende Einstellung gestartet" . "</h3>";
echo "Bitte laden sie Die Seite nicht neu weiter installation info werden hier angezeigt" . "<p></p>" ;
echo "<p>"."Ihre Wlan name     :" . $wn . "</p>";
echo "Thre Wlan password :".  $wp . "<p></p>";
echo "eth0 network Einstellung :" . "<p></p>";
echo "- Ip Adresse    :".  $et0_a . "<p></p>";
echo "- submask       :".  $et0_m . "<p></p>";
echo "- DNS           :".  $et0_d . "<p></p>";
echo "eth1 network Einstellung" . "<p></p>";
echo "- Ip Adresse    :".  $et1_r . "<p></p>";
echo "- subnet        :".  $et1_a . "<p></p>";
echo "- Submask       :".  $et1_sm . "<p></p>";
echo "- DNS           :".  $et1_d . "<p></p>";
echo "- dhcp anfang   :".  $et1_dha . "<p></p>";
echo "- dhcp ende     :".  $et1_dhe . "<p></p>";
echo "WLAN network Einstellung" . "<p></p>";
echo "- Ip Adresse    :".  $wl_r . "<p></p>";
echo "- subnet        :".  $wl_a . "<p></p>";
echo "- Submask       :".  $wl_sm . "<p></p>";
echo "- DNS           :".  $wl_d . "<p></p>";
echo "- dhcp anfang   :".  $wl_dha . "<p></p>";
echo "- dhcp ende     :".  $wl_dhe . "<p></p>";
$wlan_info=shell_exec('sudo /etc/opennetwork/verwaltung/php_verwaltung.sh x');
echo $wlan_info;

}
?>
