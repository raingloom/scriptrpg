local Point = require'Object':extend'Point'
Point._cache = setmetatable( {}, require'mt'.weak )


local allocate = Point.allocate
function Point:new( x, y )
	local ret = { x, y }
	local cache = self._cache[ x ]
	if not cache then
		cache = {}
		self._cache = cache
		cache[ y ] = ret
		return ret
	else
		local c = cache[ y ]
		if not c then
			cache[ y ] = ret
		else
			c = ret
		end
		return c
	end
end


return Point