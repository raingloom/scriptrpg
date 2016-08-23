local M = {}
local uid = 0


function M.UID( name )
	uid = uid + 1
	return (name and '_LuaFFI_' or 'LuaFFI_')..uid
end


--[[--
return: the C symbol corresponding to the class
]]
function M.makeCDef( name, cdef )
	if not cdef then
		cdef = name
		name = nil
	end
	local uid = M.UID( name )
	ffi.cdef(string.format([[
		typedef struct { %s } %s;
	]], cdef, uid ))
	return uid
end


function M.CDEF( f, ... )
	local _ENV = setmetatable( {}, { __index = function( _, i ) return _ENV[i] or i end } )
	return f( ... )
end


return M