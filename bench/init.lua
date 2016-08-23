local M = {}


function M.bench( body, seconds )
	seconds = seconds or 1
	return (loadstring or load)(string.format([[
		local T=os.time
		local t=T()+%s
		local i=0
		while T()<t do
			%s
			i=i+1
		end
		return i
	]], seconds, body ))
end


return M