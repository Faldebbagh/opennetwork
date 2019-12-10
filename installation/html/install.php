<?php echo "Installation Starten !";?>
<!DOCTYPE html>
<html>
<title>OpenNetwork Install</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="w3.css">
<link rel="stylesheet" href="main.css">
<body class="home">
  <script language="javascript" src="jquery.js" type="text/javascript"></script>
  <div style="margin-left:110px">
    <div id="Wlan_verwaltung" class="w3-container Inhalt w3-animate-left">
      <form name="eingabe" action="" method="get">
            <p><strong>Wlan Verwaltung Menu !</strong></p>
            <label><input type="radio"  value="1" />Installation Starten<br /></label>
            <label><input type="radio"  value="2" /> wlan Anschalten<br /></label>
            <label><input type="radio"  value="wlan_info" /> wlan Name und Password anzeigen<br /></label>
            <label><input type="radio"  value="wlan_change" /> wlan Name und Password ändern<br /></label>
            <br />
      </form>
    </div>
  </div>



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
</body>

