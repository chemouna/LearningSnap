
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <title>Snap web server</title>
    <link rel="stylesheet" type="text/css" href="screen.css"/>
  </head>
  <body>
    <div id="content">
      <h1>It works!</h1>
      <p>
        This is a simple demo page served using
        <a href="http://snapframework.com/docs/tutorials/heist">Heist</a>
        and the <a href="http://snapframework.com/">Snap</a> web framework.
      </p>
      <p>Let's loop from 1 to 10!</p>
      <ul>
      <loop from="1" to="10">
        <li>This is step number <step/>...</li>
      </loop>
      </ul>
    </div>
  </body>
</html>

