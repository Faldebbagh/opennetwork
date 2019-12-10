<?php
error_reporting(E_ALL);
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
            echo "______________ ";
    }

    switch($_GET['ip_menu']) {
        case 1:
            $ip_sperr=$_GET['ip'];
	    if (!empty($ip_sperr)){
	    $ip_change = shell_exec("sudo /etc/opennetwork/verwaltung/php_verwaltung.sh S '".$ip_sperr."'");
            echo $ip_change;
	    }
            break;

        case 2:
            $ip_entsperr=$_GET['ip'];
            if (!empty($ip_entsperr)){
	             $ip_change = shell_exec("sudo /etc/opennetwork/verwaltung/php_verwaltung.sh N '".$ip_entsperr."'");
               echo $ip_change;
		}
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
<html>
<title>OpenNetwork panel</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="w3.css">
<link rel="stylesheet" href="main.css">
<body class="home">
<script language="javascript" src="jquery.js" type="text/javascript"></script>
  <div class="w3-sidebar w3-bar-block w3-black w3-card" style="width:130px">
  		<h5 class="w3-bar-item">Menu</h5>
		<button class="w3-bar-item w3-button tablink" onclick="openfunk(event, 'home')">HOME</button>
		<button class="w3-bar-item w3-button tablink" onclick="openfunk(event, 'Wlan_verwaltung')">WLAN</button>
		<button class="w3-bar-item w3-button tablink" onclick="openfunk(event, 'sperr_verwaltung')">B_list</button>
		<button class="w3-bar-item tablink" onclick="openfunk(event, 'sperr_list')" style="display:none">Sperr Listen</button>
		<button class="w3-bar-item tablink" onclick="openfunk(event, 'sys_status')" style="display:none">system Status</button>
		<li class="dropdown ">
    			<a href="javascript:void(0)" class="dropbtn">Info</a>
    			<div class="dropdown-content">
      				<button class="w3-bar-item tablink" onclick="openfunk(event, 'sperr_list')" style="background-color:#f9f9f9">Sperr Listen</button>
      				<button class="w3-bar-item tablink" onclick="openfunk(event, 'sys_status')" style="background-color:#f9f9f9">system status</button>
			</div>
  		</li>
	</div>
	<div style="margin-left:130px">
		<div id="Wlan_verwaltung" class="w3-container Inhalt w3-animate-left" style="display:none">
			<form name="eingabe" action="" method="get">
    				<p><strong>Wlan Verwaltung Menu !</strong></p>
            <label><input type="radio" name="wlan" value="1" /> Wlan Ausschalten<br /></label>
    				<label><input type="radio" name="wlan" value="2" /> wlan Anschalten<br /></label>
    				<label><input type="radio" name="wlan" value="wlan_info" /> wlan Name und Password anzeigen<br /></label>
    				<label><input type="radio" name="wlan" value="wlan_change" /> wlan Name und Password ändern<br /></label>
    				<br />
    				<input type="submit" value="absenden"/>
			</form>
  		</div>
	<div id="sperr_verwaltung" class="w3-container Inhalt w3-animate-left" style="display:none">
		<form name="eingabe" action="" method="get">
    			<p><strong>Sperrverwaltung menu!</strong></p>
    			<input type="radio"  name="ip_menu" value="ip_sp" /> Neu Ip Adrese sperren<br />
    			<input  type="radio" name="ip_menu" value="ip_ent" /> Ip Andresse Entsperren<br />
    			<input onclick="mac_sperr()" type="radio" name="ip_menu" value="3" /> Mac Adresse sperren <br />
    			<input onclick="mac_entsperr()" type="radio" name="ip_menu" value="4" /> Mac Adresse Entsperren <br />
    			<input onclick="web_sperr()" type="radio" name="ip_menu" value="5" /> Web-Domain  sperren <br />
    			<input onclick="web_entsperr()" type="radio" name="ip_menu" value="6" /> Web-Domain  Entsperren <br />
    			<br />
    			<input  type="submit" value="absenden" style="display:none"/>
		</form>
	</div>

  <div class="ip_ent modal">
<span class="close">&times;</span>
<div class="modal-content">
    <form action="bash.php?">
			<input type="radio" name="ip_menu" value="2" checked style="display:none" />
  			Ip Adresse zum Entsperren:<br>
  			<input id="ip_entsperr" type="text" name="ip" value="">
  			<br><br>
  			<input type="submit" value="Submit">
		</form>
  </div>
	</div>

	<div class="ip_sp modal">
    <span class="close">&times;</span>
<div class="modal-content">
    <form action="bash.php?">
			<input type="radio" name="ip_menu" value="1" checked style="display:none" />
  			Ip Adresse zum sperrren:<br>
  			<input id="ip_sperrung" type="text" name="ip" value="">
  			<br><br>
  			<input type="submit" value="Submit">
		</form>
  </div>
	</div>


	<div class="modal wlan_change">
    <span id="hide"  class="close">&times;</span>
    <div class="modal-content">
		<form action="bash.php?">
			<input type="radio" name="wlan" value="4" checked style="display:none" />
  			<br>Gebn Sie Ihre Neuen Wlan Name ein:<br />
        <br><input id="" type="text" name="wlan_name" value=""/></br>
  			<br>Gebn Sie Ihre Neuen Wlan Password  ein: Muss min. 8 zeischnen <br />
  			<br><input id="wlan_password" type="password" name="wlan_password" value=""/> <input type="checkbox" onclick="pass_show()"> Show Password </br>
  			<br><br>
  			<input type="submit" value="Submit">
		</form>
  </div>
	</div>
  <div class="wlan_info modal">
    <span class="close">&times;</span>
<div class="modal-content">
		<?php
		$wlan_info=shell_exec('sudo /etc/opennetwork/verwaltung/php_verwaltung.sh E');
		echo $wlan_info; ?>
	</div>
</div>

	<div id="sperr_list" class="w3-container Inhalt w3-animate-left" style="display:none" >
		<h1>Sperr Listen</h1>
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
				echo $mac; ?></div>
			</div>
<div id="sys_status" class="w3-container Inhalt w3-animate-left" style="display:none" >
	<h1>System Status</h1>
	<div class="scroll_dinst">
		<h3>Dinste Status</h3>
		<?php
		$stu=shell_exec('sudo /etc/opennetwork/verwaltung/php_verwaltung.sh');
		echo $stu; ?>
	</div>
	<div class="scroll">
		<h3>Verbunde Geräte</h3>
		<?php
		$di=shell_exec('sudo /etc/opennetwork/verwaltung/php_verwaltung.sh C');
		echo $di; ?>
	</div>
</div>
<script>
function openfunk(evt, funkName) {
  var i, x, tablinks;
 x = document.getElementsByClassName("Inhalt");
  for (i = 0; i < x.length; i++) {
    x[i].style.display = "none";
  }
  tablinks = document.getElementsByClassName("tablink");
  for (i = 0; i < x.length; i++) {
    tablinks[i].className = tablinks[i].className.replace(" w3-border-red", "");
  }

  document.getElementById(funkName).style.display = "block";
  evt.currentTarget.firstElementChild.className += " w3-border-red";
}

function pass_show() {
  var x = document.getElementById("wlan_password");
  if (x.type === "password") {
    x.type = "text";
  } else {
    x.type = "password";
  }
}
</script >

<script>

  $(document).ready(function() {
              $('input[type="radio"]').click(function() {
                  var inputValue = $(this).attr("value");
                  var targetBox = $("." + inputValue);
                  $(".formular").not(targetBox).hide();
                  $(targetBox).fadeIn(1200);

              });
            });
</script>

<script>
var closebtns = document.getElementsByClassName("close");
var i;

for (i = 0; i < closebtns.length; i++) {
  closebtns[i].addEventListener("click", function() {
    this.parentElement.style.display = 'none';
  });
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
<script>

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

</body>
</html>
