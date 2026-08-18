function Linemode:mtime()
	local time = math.floor(self._file.cha.mtime or 0)
	if time == 0 then
		return ""
	elseif os.date("%Y", time) == os.date("%Y") then
		return os.date("%d/%m %H:%M", time)
	else
		return os.date("%d/%m  %Y", time)
	end
end

function Linemode:btime()
	local time = math.floor(self._file.cha.btime or 0)
	if time == 0 then
		return ""
	elseif os.date("%Y", time) == os.date("%Y") then
		return os.date("%d/%m %H:%M", time)
	else
		return os.date("%d/%m  %Y", time)
	end
end