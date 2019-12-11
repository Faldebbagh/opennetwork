<?php echo "Installation Starten !";?>
<!DOCTYPE html>
<html>
<title>OpenNetwork Install</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="w3.css">
<link rel="stylesheet" href="main.css">
<body class="home">
  <script language="javascript" src="jquery.js" type="text/javascript"></script>
  <script>
$(document).ready(function(){
  $('input[type="radio"]').click(function(){
      var inputValue = $(this).attr("value");
      var targetBox = $("." + inputValue);
      $(targetBox).show();
  });
});
</script>
<script>
$(document).ready(function(){
$('input[type="radio"]').click(function(){
    var inputValue = $(this).attr("value");
    var targetBox = $("." + inputValue);
    $(".modal-content").not(targetBox).hide();
    $(targetBox).show();
});
});
function pass_show() {
  var x = document.getElementById("wlan_password");
  if (x.type === "password") {
    x.type = "text";
  } else {
    x.type = "password";
  }
}
$(document).ready(function() {
  $(window).keydown(function(event){
    if(event.keyCode == 13) {
      event.preventDefault();
      return false;
    }
  });
});
</script>
    <div class="w3-animate-left" style="margin-left:50px">
            <p><strong>Ersteinrichtung</strong></p>
            <input class="install" type="radio"  name="ip_menu" value="auto" /> Installation starten<br />
    </div>
 <div class="auto formular">
<div  class="w3-animate-left" style="margin-left:80px">
   <input type="radio" name="ip_menu" value="auto_install" />auto install<br />
    <div  class="auto_install modal-content w3-animate-left" style="margin-left:150px">
      <form action="bash.php?">
        <p>wollen Sie dass Ihre RPI automatische Einstellungen vorgenommen             </p>
        <p>RPI           ||  IP : DHCP - Auto                                          </p>
        <p>wlan          ||  Ip : 192.168.1.1/24    DHCP 192.168.1.100 - 192.168.1.254</p>
        <p>Eth1          ||  IP : 192.168.2.1/24    DHCP 192.168.2.100 - 192.168.2.254</p>
        <p>Wlan Name: OpenNwtwork     Wlan kanal : 10       Wlan Kenntwort : 4EMT7E9CPP </p>
        <input type="submit" value="Submit">
    </form>
   </div>
   <input  type="radio" name="ip_menu" value="pro_install" />erwertet install<br />
 </div>
   <div  class="pro_install formular w3-animate-left" style="margin-left:110px">
      <input  type="radio" name="ip_menu" value="wlan" /> 1. Acssecpont conf<br />
      <input  type="radio" name="ip_menu" value="eth0" /> 2. eth0 conf<br />
      <input  type="radio" name="ip_menu" value="eth1" /> 3. eth1 conf<br />
      <input  type="radio" name="ip_menu" value="wlan0" /> 4. wlan0 conf<br />
   </div>
   <div  style="margin-left:130px">
     <form action="bash.php?">
       <div class="wlan modal-content w3-animate-left">
         <br>Gebn Sie Ihre Neuen Wlan Name ein:<br />
          <br><input id="" type="text" name="wlan_name" value=""/></br>
         <br>Gebn Sie Ihre Neuen Wlan Password  ein: Muss min. 8 zeischnen <br />
         <br><input id="wlan_password" type="password" name="wlan_password" value=""/> <input type="checkbox" onclick="pass_show()"> Show Password </br>
       </div>
       <div class="eth0 modal-content w3-animate-left">
        <br>eth0 IpAdress  : <input id="" type="text" name="wlan_name" value=""/></br>
        <br>eth0 Submask   :   <input id="" type="text" name="wlan_name" value=""/></br>
        <br>eth0 DNS       :   <input id="" type="text" name="wlan_name" value=""/></br>
       </div>
       <div class="eth1 modal-content w3-animate-left">
         <br>etho Einstellung ex. LAN  </br>
          <br>subnet    : <input id="" type="text" name="wlan_name" value="ex. 192.168.1.0"/></br>
          <br>Submask     : <input id="" type="text" name="wlan_name" value="ex. 192.168.1.1"/></br>
          <br>DNS         : <input id="" type="text" name="wlan_name" value="ex. 192.168.1.1"/></br>
          <br>dhcp anfang : <input id="" type="text" name="wlan_name" value="ex. 192.168.1.1"/></br>
          <br>dhcp End    : <input id="" type="text" name="wlan_name" value="ex. 192.168.1.255"/></br>
          <br> 
       <div class="wlan0 modal-content w3-animate-left">
         <br>Gebn Sie Ihre Neuen Wlan Name ein:<br />
          <br><input id="" type="text" name="wlan_name" value=""/></br>
         <br>Gebn Sie Ihre Neuen Wlan Password  ein: Muss min. 8 zeischnen <br />
         <br><input id="wlan_password" type="password" name="wlan_password" value=""/> <input type="checkbox" onclick="pass_show()"> Show Password </br>
       </div>
     </form>
   </div>

</body>
