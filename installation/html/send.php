<?php
$in=$_POST['install'];
if ($in == "auto"){
$wn=$_POST['wname'];
$wp=$_POST['wpassword'];
echo "<h3>" . "Ihre Installation Wird mit die Folgende Einstellung gestartet" . "</h3>";
echo "Bitte laden sie Die Seite nicht neu weiter installation info werden hier angezeigt" . "<p></p>" ;
echo "Ihre Wlan name :" . $wn . "<p></p>";
echo "Thre Wlan password :".  $wp . "<p></p>";
}
?>
