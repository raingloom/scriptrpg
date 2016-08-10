local Memoizer = require'Object':extend'Memoizer'
local NIL = {'NIL'}


function Memoizer:__call( ... )
	local v = self:get( ... )
	if v==nil then
		v = self.func( ... )
		if v==nil then
			v = NIL
		end
		self:set( v, ... )
	end
	return v
end


function Memoizer:get( ... )
	local arg = table.pack( ... )
	local cache = self.cache
	for i = 1, arg.n do
		local a = arg[ i ]
		if a==nil then
			a = NIL
		end
		cache = cache[ a ]
		if cache==nil then
			return nil
		end
	end
	return getmetatable( cache ) ~= NIL and cache or nil
end


function Memoizer:set( v, ... )
	local cache = self.cache
	local arg = table.pack( ... )
	for i = 1, arg.n-1 do
		local a = arg[ i ]
		if a==nil then
			a = NIL
		end
		local c = cache[ a ]
		if c==nil then
			c = setmetatable( {}, NIL )--mark the table so vararg functions can't access the cache tree
			cache[ a ] = c
		end
		cache = c
	end
	cache[ arg.n ] = v
end
	

function Memoizer:initialize( f, weak )
	self.cache = setmetatable( {}, NIL )
	self.func = f
end


function Memoizer:clear()
	self.cache = setmetatable( {}, NIL )
end


function Memoizer:wrap()
	return function( ... )
		return self( ... )
	end
end


return Memoizer