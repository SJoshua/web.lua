<!doctype html>
<html>
	<head>
		<title> web.lua example </title>
	</head>
	<body>
		<h2> Calculation </h2>
		<p> 1 + 1 = <?lua io.write(1 + 1) ?></p>
		<h2> Read File </h2>
		<p> Debug.bat: <pre><?lua 
			local f = io.open("debug.bat", "r") 
			io.write(f:read("*a"))
			f:close()
		?></pre> </p>
		<h2> GET </h2>
		<p> for each in GET(table):</p>
		<?lua
			for k, v in pairs(GET) do
				io.write("<p>", k, " = ", v, "</p>")
			end
		?>
		<h2> Expection </h2>
		<p> Do sth: <?lua dosth() ?> </p>
	</body>
</html>