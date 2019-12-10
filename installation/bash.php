<?php

    switch($_GET['wlan']) {
        case 1:
            $wlan_aus = shell_exec('sudo /etc/opennetwork/verwaltung/php_verwaltung.sh A');
	    echo "<pre>$wlan_aus</pre>";
            break;
     
        case 2:
            $wlan_an = shell_exec('sudo /etc/opennetwork/verwaltung/php_verwaltung.sh B');
	    echo "<pre>$wlan_an</pre>";
            break;
             
        case 3:
            $wlan_info = shell_exec('sudo /etc/opennetwork/verwaltung/php_verwaltung.sh E');
            echo "<pre>$wlan_info</pre>";
            break;
             
        case 4:
	    $wlan_name=$_GET['wlan_name'];
	    $wlan_password=$_GET['wlan_password'];
            $wlan_change = shell_exec("sudo /etc/opennetwork/verwaltung/php_verwaltung.sh D '".$wlan_name."' '".$wlan_password."'");
	    echo $wlan_change;
            break;
     
        default:
	   $status= shell_exec("sudo /etc/opennetwork/verwaltung/php_verwaltung.sh T");
            echo "$status";
    }

    switch($_GET['ip_menu']) {
        case 1:
	    $ip_sperr=$_GET['ip'];
            $ip_change = shell_exec("sudo /etc/opennetwork/verwaltung/php_verwaltung.sh S '".$ip_sperr."'");
            echo $ip_change;
            break;

        case 2:
            $ip_entsperr=$_GET['ip'];
            $ip_change = shell_exec("sudo /etc/opennetwork/verwaltung/php_verwaltung.sh N '".$ip_entsperr."'");
            echo $ip_change;
            break;

        case 3:
            $mac_sperr=$_GET['mac'];
	    $mac_sperr_user=$_GET['mac_user'];
            $mac_change = shell_exec("sudo /etc/opennetwork/verwaltung/php_verwaltung.sh M '".$mac_sperr."' '".$mac_sperr_user."'");
            echo $mac_change;
            break;

        case 4:
            $mac_entsperr=$_GET['mac'];
            $mac_change = shell_exec("sudo /etc/opennetwork/verwaltung/php_verwaltung.sh V '".$mac_entsperr."'");
            echo $mac_change;
            break;

        case 5:
            $web_sperr=$_GET['web'];
            $web_change = shell_exec("sudo /etc/opennetwork/verwaltung/php_verwaltung.sh W '".$web_sperr."'");
            echo $web_change;
            break;
        case 6:
            $web_entsperr=$_GET['web'];
            $web_change = shell_exec("sudo /etc/opennetwork/verwaltung/php_verwaltung.sh Y '".$web_entsperr."'");
            echo $web_change;
            break;
        default:
            echo '';
    }

?>
<!DOCTYPE html>
<html lang="de">
<head>
<title>OpenNetwork Panel</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="w3.css">
<style>
.scroll_web {
height:150px;
width:120px;
border:0px
solid #ccc;
font:16px/26px Georgia, Garamond, Serif;
overflow:auto;
}

.scroll_mac {
height:150px;
width:280px;
border:0px
solid #ccc;
font:16px/26px Georgia, Garamond, Serif;
overflow:auto;
}
.scroll2 {
height:150px;
width:150px;
border:0px 
solid #ccc;
font:16px/26px Georgia, Garamond, Serif;
overflow:auto;
}
.scroll {
height:150px;
width:90%;
border:0px
solid #ccc;
font:15px Georgia, Garamond, Serif;
overflow:auto;
}
.scroll > span {
    background: #bbb;}
* {
  box-sizing: border-box;
}

body {
  background-image: url("back.png"); 
  background-position: center;
  background-repeat: no-repeat;
  background-size: cover;
  width: 100%;
  font-family: Arial, Helvetica, sans-serif;
 font-size: 13px;
}

/* Style the header */
.header {
  background-color: #f1f1f1;
  padding: 30px;
  text-align: center;
  width: auto;
  font-size: 35px;
}

/* Create three equal columns that floats next to each other */
.column_re {
  float: right;
  width: 28.46%;
  padding: 5px;
  height: auto; /* Should be removed. Only for demonstration */
}

.column {
  float: left;
  width: 62.99%;
  padding: 3px;
  height: 300px; /* Should be removed. Only for demonstration */
}

/* Clear floats after the columns */
.row:after {
  content: "";
  display: table;
  clear: both;
}

/* Style the footer */
.footer {
  background-color: #f1f1f1;
  padding: 10px;
  text-align: center;
}

/* Responsive layout - makes the three columns stack on top of each other instead of next to each other */
@media (max-width: 500px) {
  .column {
    width: 100%;
  }
}
</style>
</header>
<body>
<script class="input">
function myFunction() {
  var name = prompt("Please enter your wlan name:", "OpenNetwork");
  var password = prompt("Please enter your password:", "12345678");
  if ( name == null ||name == "" ||password == "" ||password == null ) {
    alert('Wurde Abgebrochen');
  } else {
    document.location="./bash.php?wlan=4&wlan_name="+name+"&wlan_password="+password;
  }
}
</script>
<div class="header">
<img src="logo.png" class="w3-hover-sepia" style="width:880px">
</div>
<table class="row">
<tr>
<td class="column" style="background-color:#bbb;" ><form name="eingabe" action="" method="get">
    <p><strong>Wlan Verwaltung Menu !</strong></p>
    <input type="radio" name="wlan" value="1" /> Wlan Ausschalten                        <br />
    <input type="radio" name="wlan" value="2" /> wlan Anschalten                         <br />
    <input type="radio" name="wlan" value="3" /> wlan Name und Password anzeigen         <br />
    <input onclick="myFunction()" type="radio" name="wlan" value="4" /> wlan Name und Password ändern           <br />
    <br />
    <input type="submit" value="absenden" />
</form>
</td>
<td class="column" style="background-color:#bbb;"><form name="eingabe" action="" method="get">
    <p><strong>Sperr Verwaltung menu! </strong></p>
    <input onclick="ip_sperr()" type="radio" name="ip_menu" value="1" /> Neu Ip Adrese sperren		<br />
    <input onclick="ip_entsperr()" type="radio" name="ip_menu" value="2" /> Ip Andresse Entsperren     		<br />
    <input onclick="mac_sperr()" type="radio" name="ip_menu" value="3" /> Mac Adresse sperren <br />
    <input onclick="mac_entsperr()" type="radio" name="ip_menu" value="4" /> Mac Adresse Entsperren <br />
    <input onclick="web_sperr()" type="radio" name="ip_menu" value="5" /> Web-Domain  sperren <br />
    <input onclick="web_entsperr()" type="radio" name="ip_menu" value="6" /> Web-Domain  Entsperren <br />
    <br />
    <input  type="submit" value="absenden" />
</form>
</td>

</tr>

<div class="column_re" style="background-color:#bbb;" > 
<h1>Info </h1>
<h3>Aktuelle verbundene Geräte</h3>
<div class="scroll"><?php
$di=shell_exec('sudo /etc/opennetwork/verwaltung/php_verwaltung.sh C'); 
echo $di; ?> </div>
<h1>__________________________________</h1>
<h3>gesperrte websieten</h3>
<div class="scroll_web"><?php
$web=shell_exec('sudo /etc/opennetwork/verwaltung/php_verwaltung.sh F');
echo $web; ?> </div>
<h1>__________________________________</h1>
<h3>gesperrte Ip Adressen</h3>
<div class="scroll2"><?php
$ip=shell_exec('sudo /etc/opennetwork/verwaltung/php_verwaltung.sh G');
echo $ip; ?> </div>
<h1>__________________________________</h1>
<h3>gesperrte Mac Adressen</h3>
<div class="scroll_mac"><?php
$mac=shell_exec('sudo /etc/opennetwork/verwaltung/php_verwaltung.sh H');
echo $mac; ?> </div>
</div>
</table>
</body>
<script class="input">
function ip_sperr() {
  var angabe = prompt("Please enter Ip Adresse :", "192.168.0.1");
  if ( angabe == null ||angabe == "" ) {
    alert('Wurde Abgebrochen');
  } else {
    document.location="./bash.php?ip_menu=1&ip="+angabe;
  }
}
</script>

<script class="input">
function ip_entsperr() {
  var angabe = prompt("Please enter Ip Adresse :", "192.168.0.1");
  if ( angabe == null ||angabe == "" ) {
    alert('Wurde Abgebrochen');
  } else {
    document.location="./bash.php?ip_menu=2&ip="+angabe;
  }
}
</script>
<script class="input">
function mac_sperr() {
  var angabe = prompt("Please enter mac Adresse :", "1a:2b:3d:59:4a:a5");
  var user = prompt("Please enter mac Adresse user :", "Mustermann");
  if ( angabe == null ||angabe == "" ) {
    alert('Wurde Abgebrochen');
  } else {
    document.location="./bash.php?ip_menu=3&mac="+angabe+"&mac_user="+user;
  }
}
</script>

<script class="input">
function mac_entsperr() {
  var angabe = prompt("Please enter mac Adresse :", "1a:2b:3d:59:4a:a5");
  if ( angabe == null ||angabe == "" ) {
    alert('Wurde Abgebrochen');
  } else {
    document.location="./bash.php?ip_menu=4&mac="+angabe;
  }
}
</script>

<script class="input">
function web_sperr() {
  var angabe = prompt("Please enter Domain :", "www.google.de");
  if ( angabe == null ||angabe == "" ) {
    alert('Wurde Abgebrochen');
  } else {
    document.location="./bash.php?ip_menu=5&web="+angabe;
  }
}
</script>
<script class="input">
function web_entsperr() {
  var angabe = prompt("Please enter web-Domain:", "www.google.de");
  if ( angabe == null ||angabe == "" ) {
    alert('Wurde Abgebrochen');
  } else {
    document.location="./bash.php?ip_menu=6&web="+angabe;
  }
}
</script>
</html>
