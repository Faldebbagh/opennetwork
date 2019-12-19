<?php echo "Installation Starten !";

?>
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
<!-- Anzeigen Div Der von Radio Button Gedruckt wurde  -->
$(document).ready(function(){
$('input[type="radio"]').click(function(){
    var inputValue = $(this).attr("value");
    var targetBox = $("." + inputValue);
    $(".modal-content").not(targetBox).hide();
    $(targetBox).show();
});
});
<!-- Password Anzeigen und Hiden  -->
function pass_show() {
  var x = document.getElementById("wlan_password");
  if (x.type === "password") {
    x.type = "text";
  } else {
    x.type = "password";
  }
}
$(document).ready(function() {
$('a').on('click', function(event) {
var inputherf = $(this).attr('href');
var targetform = $("." + inputherf)
$(".modal-content").not(targetform).hide();
$(targetform).show();
return false;
});
});
</script>
<script>
$(document).ready(function(){
    $('#install_form').on('submit', function(e){
        e.preventDefault();
       var install = "conf";
       var wname = $("#wlan_name").val();
       var wpassword = $("#wlan_password").val();
       var eth0_a = $("#eth0_adresse").val();
       var eth0_m = $("#eth0_mask").val();
       var eth0_d = $("#eth0_dns").val();
       var eth0_g = $("#eth0_get").val();
       var eth1_r = $("#eth1_router").val();
       var eth1_a = $("#eth1_adresse").val();
       var eth1_sm = $("#eth1_submask").val();
       var eth1_dha = $("#eth1_dhcpa").val();
       var eth1_dhe = $("#eth1_dhcpe").val();
       var wlan_r = $("#wlan_router").val();
       var wlan_a = $("#wlan_adresse").val();
       var wlan_sm = $("#wlan_submask").val();
       var wlan_dha = $("#wlan_dhcpa").val();
       var wlan_dhe = $("#wlan_dhcpe").val();
       $(".wlan0").hide();
       $(".w3-animate-left").hide();
         $(".wating").show();
        $.ajax({
            type: "POST",
            url: 'send.php',
            data: {
              install: install,
              wname: wname,
              wpassword: wpassword,
              eth0_a: eth0_a,
              eth0_m: eth0_m,
              eth0_d: eth0_d,
              eth0_g: eth0_g,
              eth1_r: eth1_r,
              eth1_a: eth1_a,
              eth1_sm: eth1_sm,
              eth1_dha: eth1_dha,
              eth1_dhe: eth1_dhe,
              wlan_r: wlan_r,
              wlan_a: wlan_a,
              wlan_sm: wlan_sm,
              wlan_dha: wlan_dha,
              wlan_dhe: wlan_dhe,
            },
            success: function(data){
                $('#results').html(data);
                $(".wating").hide();
            }
        });
    });
});
</script>
<script>
$(document).ready(function(){
    $('#install_auto').on('submit', function(e){
        e.preventDefault();
        $(".wating").show();
        var install = "auto";
        $(".auto_install").hide();
        $(".w3-animate-left").hide();
         $.ajax({
           type: "POST",
           url: 'send.php',
           data: {install: install},
           success: function(data){
           $('#results').html(data);
           $(".wating").hide();
           }
       });
   });
});
</script>
<div class="wating" >
  <H3>Die Installation kann ca. 5 min dauern ..................... </h3>
  </div>
  <div  id="results" style="margin-left:50px;font-size:small;padding: 10px;width:35%; overflow:auto;" >
<!-- All data will display here  -->
  </div>
    <div class="w3-animate-left" style="margin-left:50px">
            <p><strong>Ersteinrichtung</strong></p>
            <input class="install" type="radio"  name="ip_menu" value="auto" /> Installation starten<br />
    </div>
 <div class="auto formular">
<div  class="w3-animate-left" style="margin-left:80px">
   <input type="radio" name="ip_menu" value="auto_install" />auto install<br />
    <div  class="auto_install modal-content w3-animate-left" style="margin-left:150px">
      <form id="install_auto" method="post">
        <p>wollen Sie dass Ihre RPI automatische Einstellungen vorgenommen             </p>
        <p>RPI           ||  IP : DHCP - Auto                                          </p>
        <p>wlan          ||  Ip : 192.168.1.1/24    DHCP 192.168.1.100 - 192.168.1.254</p>
        <p>Eth1          ||  IP : 192.168.2.1/24    DHCP 192.168.2.100 - 192.168.2.254</p>
        <p>Wlan Name: OpenNwtwork     Wlan kanal : 10       Wlan Kenntwort : 4EMT7E9CPP </p>
        <input id="submit" type="submit" value="absenden"/>
    </form>
   </div>
   <input  type="radio" name="ip_menu" value="pro_install" />erwertet install<br />
 </div>
   <div  class="pro_install formular w3-animate-left" style="margin-left:110px">
      <input  type="radio" name="Install_menu" value="wlan" /> 1. Accesspoint conf<br />
      <input  type="radio" name="Install_menu" value="eth0" /> 2. Eth0 confing     <br />
      <input  type="radio" name="Install_menu" value="eth1" /> 3. Eth1 confing<br />
      <input  type="radio" name="install_menu" value="wlan0" /> 4. Wlan confing<br />
   </div>
   <div  style="margin-left:130px">
     <form id="install_form" method="post">
       <div class="wlan modal-content w3-animate-left">
         <h3>Einstellung Ihre Accesspoint</h3>
         <br>Gebn Sie Ihre Neuen Wlan Name ein:<br />
         <p><input required id="wlan_name" type="text" value=""placeholder="wlan Name (erforderlich)"/></p>
         <br>Gebn Sie Ihre Neuen Wlan Password  ein: Muss min. 8 zeischnen <br />
         <p><input required id="wlan_password" type="password" value="" placeholder="wlan Name (erforderlich)"/>  <input type="checkbox" onclick="pass_show()"> Show Password </p>
         <a href="eth0">Next &raquo;</a>
       </div>
       <div class="eth0 modal-content w3-animate-left">
         <h3>eth0 network Einstellung Intern. LAN  </h3>
        <br>eth0 IpAdress  :</br><p><input required id="eth0_adresse" type="text" placeholder="ex. 192.168.178.1" value=""/></p>
        <br>eth0 Submask   :</br><p><input required id="eth0_mask" type="text" placeholder="ex. 255.255.255.0" value=""/></p>
        <br>eth0 DNS       :</br><p><input required id="eth0_dns" type="text" placeholder="ex. 192.168.178.1" value=""/></p>
        <br>eth0 Gateway       :</br><p><input required id="eth0_get" type="text" placeholder="ex. 192.168.178.1" value=""/></p>
        <a href="wlan">&laquo; Previous</a>
        <a href="eth1">Next &raquo;</a>
       </div>
       <div class="eth1 modal-content w3-animate-left">
         <h3>eth1 network Einstellung ex. LAN  </h3>
          <br>RouterIp    : </br><p><input required id="eth1_router" type="text" placeholder="ex. 192.168.1.1" value=""/></p>
          <br>subnet      : </br><p><input required id="eth1_adresse" type="text" placeholder="ex. 192.168.1.0" value=""/></p>
          <br>Submask     : </br><p><input required id="eth1_submask" type="text"  placeholder="ex. 192.168.1.1" value=""/></p>
          <br>dhcp anfang : </br><p><input required id="eth1_dhcpa" type="text"  placeholder="ex. 192.168.1.1" value=""/></p>
          <br>dhcp End    : </br><p><input required id="eth1_dhcpe" type="text"  placeholder="ex. 192.168.1.255" value=""/></p>
          <br></br>
          <a href="eth0">&laquo; Previous</a>
          <a href="wlan0">Next &raquo;</a>
        </div>
       <div class="wlan0 modal-content w3-animate-left">
         <h3>Wlan Network Einstellung Access point</h3>
         <br>RouterIp    : </br><p><input required id="wlan_router" type="text" placeholder="ex. 192.168.2.1" value=""/></p>
         <br>subnet      : </br><p><input required id="wlan_adresse" type="text" placeholder="ex. 192.168.2.0" value=""/></p>
         <br>Submask     : </br><p><input required id="wlan_submask" type="text" placeholder="ex. 192.168.2.1" value=""/></p>
         <br>dhcp anfang : </br><p><input required id="wlan_dhcpa" placeholder="ex. 192.168.2.1" value=""/></p>
         <br>dhcp End    : </br><p><input required id="wlan_dhcpe" type="text" placeholder="ex. 192.168.2.225" value=""/></p>
         <a href="eth1">&laquo; Previous</a>
         <input  type="submit" value="absenden"/>
       </div>
     </form>
   </div>
</body>
