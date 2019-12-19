<?php
$in=$_POST['install'];
if ($in == "conf"){
$keys = [
  'wname',
  'wpassword',
  'eth0_a',
  'eth0_m',
  'eth0_d',
  'eth0_g',
  'eth1_r',
  'eth1_a',
  'eth1_sm',
  'eth1_dha',
  'eth1_dhe',
  'wlan_r',
  'wlan_a',
  'wlan_sm',
  'wlan_dha',
  'wlan_dhe'
];
$values = [];

foreach ($keys as $key) {
  $values[$key] = $_POST[$key];
}

echo "<h3>" . "Ihre Installation Wird mit die Folgende Einstellung gestartet" . "</h3>";
echo "Bitte laden sie Die Seite nicht neu weiter installation info werden hier angezeigt" . "<p></p>" ;
echo "<p>"."Ihre Wlan name     :" . $values["wname"] . "</p>";
echo "Thre Wlan password :".  $values["wpassword"] . "<p></p>";
echo "eth0 network Einstellung :" . "<p></p>";
echo "- Ip Adresse    :".  $values["eth0_a"] . "<p></p>";
echo "- submask       :".  $values["eth0_m"]. "<p></p>";
echo "- DNS           :".  $values["eth0_d"] . "<p></p>";
echo "- Gateway       :".  $values["eth0_g"] . "<p></p>";
echo "eth1 network Einstellung" . "<p></p>";
echo "- Ip Adresse    :".  $values["eth1_r"] . "<p></p>";
echo "- subnet        :".  $values["eth1_a"] . "<p></p>";
echo "- Submask       :".  $values["eth1_sm"] . "<p></p>";
echo "- dhcp anfang   :".  $values["eth1_dha"] . "<p></p>";
echo "- dhcp ende     :".  $values["eth1_dhe"] . "<p></p>";
echo "WLAN network Einstellung" . "<p></p>";
echo "- Ip Adresse    :".  $values["wlan_r"] . "<p></p>";
echo "- subnet        :". $values["wlan_a"]  . "<p></p>";
echo "- Submask       :".  $values["wlan_sm"] . "<p></p>";
echo "- dhcp anfang   :".  $values["wlan_dha"] . "<p></p>";
echo "- dhcp ende     :".  $values["wlan_dhe"] . "<p></p>";

$string = "";
foreach ($values as $value) {
  $string = $string.'"'.$value.'"'.' ';
}
$wlan = shell_exec("sudo /etc/opennetwork/verwaltung/php_verwaltung.sh Z ".$string );
echo $wlan;
}


if ($in == "auto"){
  echo "<h3>" . "Ihre Installation Wird gestartet" . "</h3>";
  echo "Bitte laden sie Die Seite nicht neu weiter installation info werden hier angezeigt" . "<p></p>" ;
  $wlan_info=shell_exec('sudo /etc/opennetwork/verwaltung/php_verwaltung.sh X');
  echo $wlan_info;
}
?>
