--localize for safety
local setmetatable, type
    = setmetatable, type

local data = setmetatable( {}, require'mt'.weak )
local cache = setmetatable( {}, require'mt'.weak )
local mt = {}
mt.__metatable = false


local function overlay( t )
	local ret = cache[ t ]
	if ret then
		return ret
	end
	setmetatable( ret, mt )
	cache[ t ] = ret
	return ret
end


function mt:__index( k )
	if type( k ) == 'table' then
		return