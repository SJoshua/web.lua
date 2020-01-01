<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
    <meta name="description" content="Moe Image Spider">
    <meta name="author" content="SJoshua">

    <title>Moe Image Spider</title>

    <!-- Bootstrap core CSS -->
    <link href="dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
    <link href="assets/css/ie10-viewport-bug-workaround.css" rel="stylesheet">

    <!-- Custom styles for this template -->
    <link href="cover.css" rel="stylesheet">

    <!-- Just for debugging purposes. Don't actually copy these 2 lines! -->
    <!--[if lt IE 9]><script src="assets/js/ie8-responsive-file-warning.js"></script><![endif]-->
    <script src="assets/js/ie-emulation-modes-warning.js"></script>

    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
  </head>

  <body>
    <div id="show"></div>
    <div class="site-wrapper">
      <div class="site-wrapper-inner">
        <div class="cover-container">
		  <?lua
		    if GET.mode == "tags" then
			  io.write([[
          <div class="clearfix">
		      ]])
			else
			  io.write([[
          <div class="masthead clearfix">
		      ]])
			end
      	  ?>
            <div class="inner">
              <h3 class="masthead-brand">Moe Image Spider</h3>
              <nav>
                <ul class="nav masthead-nav">
				  <?lua 
				    if GET.mode == "tags" then
				      io.write([[<li><a href="index.lua">Home</a></li> <li class="active"><a href="index.lua?mode=tags">Tags</a></li>]])
					else
                      io.write([[<li class="active"><a href="index.lua">Home</a></li> <li><a href="index.lua?mode=tags">Tags</a></li>]])
					end
				  ?>
                </ul>
              </nav>
            </div>
          </div>
          <div class="inner cover">
          <?lua
		    if GET.mode == "tags" then
			  if GET.tag and #GET.tag > 0 then
			    GET.page = tonumber(GET.page) or 1
			    list = http.request("http://moeimg.net/tag/" .. GET.tag .. "/page/" .. GET.page)
			    if (list:find([[<body class="error404">]])) then
				  io.write("Oops! Invaild tag or page.")
				elseif (not list) then
				  io.write("Oops! Failed to get list.")
				else
				  local reg_exp = [[<h2 class="title">%s*<a href=http://moeimg.net/(.-).html title=(.-)>]]
				  while (list:find(reg_exp)) do 
				    local id, name = list:match(reg_exp)
					list = list:gsub(reg_exp, "", 1)
					io.write([[<a href="#" onclick="jQuery.ajax({url: 'load.lua?id=]], id, [[', async: false, success: function(data) { document.getElementById('show').innerHTML = data;}});">]], name, "</a><br>")
				  end
			      io.write([[
		    <p class="lead">
              <a href="index.lua?mode=tags&tag=]], GET.tag, [[&page=]], (GET.page + 1), [[" class="btn btn-lg btn-default">Next</a>
            </p>
				]])
			      return
				end
			  end
			  
			  list = http.request("http://moeimg.net/taglist")
			  if (list) then
			    local reg = [[<div id=tag_cat_.- class=box_title>([^\n]-)</div>%s*<table>(.-)</table>]]
				local reg_tag = [[<a href=http://moeimg.net/tag/(.-)>(.-)</a>]]
				while (list:find(reg)) do
				  local category, tags = list:match(reg)
				  if (category and tags) then
				    io.write([[<p class="cover-heading">]], category, [[</p><p class="lead"><table><tbody>]])
					local cnt = 0
					while (tags:find(reg_tag)) do
					  if cnt == 0 then
					    io.write("<tr>")
					  end
					  local esp, name = tags:match(reg_tag)
					  io.write([[<td><a href="index.lua?mode=tags&tag=]], esp, [[">]], name, "</a></td>")
					  tags = tags:gsub(reg_tag, "", 1)
					  cnt = cnt + 1
					  if (cnt == 6) then
					    io.write("</tr>")
						cnt = 0
					  end
					end
					io.write([[</tbody></table></p>]])
				  end
				  list = list:gsub(reg, "", 1)
				end
		      else
			    io.write([[<p class="lead"> Oops! Failed to get the tags. </p>]])
			  end
			else
			  io.write([[
            <h1 class="cover-heading">Hello!</h1>
            <p class="lead">Moe Image Spider is a local image viewer for illustrations. 
			<br> It downloads pictures from web.
			<br> You can specify tag of images.</p>
            <p class="lead">
              <a href="index.lua?mode=tags" class="btn btn-lg btn-default">Get Started</a>
            </p>
              ]])
			end
	      ?>
          </div>
		  <?lua
		    if GET.mode == "tags" then
			  io.write([[
          <div class="norfoot">
		      ]])
			else
			  io.write([[
          <div class="mastfoot">
		      ]])
			end
      	  ?>
            <div class="inner">
              <p>Resource of images: <a href="http://moeimg.net/">moeimg.net</a>, Author: <a href="https://github.com/SJoshua/">@SJoshua</a>, Powered by <a href="https://github.com/SJoshua/web.lua">web.lua</a>.</p>
      </div>
    </div>

    <!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
    <script>window.jQuery || document.write('<script src="assets/js/vendor/jquery.min.js"><\/script>')</script>
    <script src="dist/js/bootstrap.min.js"></script>
    <!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
    <script src="assets/js/ie10-viewport-bug-workaround.js"></script>
  </body>
</html>
