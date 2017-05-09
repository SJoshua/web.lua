<?lua
	if tonumber(GET.id) then
		local content = http.request("http://moeimg.net/" .. GET.id .. ".html")
		if (content) then
			local reg = [[<div class="num">%d+</div>%s*<a href="(.-)" target="_blank">]]
			while (content:find(reg)) do
				io.write([[<img src="]], content:match(reg), [["/>]])
				content = content:gsub(reg, "", 1)
			end
		else
			io.write("Failed to load.")
		end
	else
		io.write("Invailed ID.")
	end
?>