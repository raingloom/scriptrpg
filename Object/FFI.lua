local ffi = require'ffi'

local M = {}
local uid = 0

M.prefix = 'LuaFFI'


function M.newUid( name )
	uid = uid + 1
	name = name and name..'_'..M.prefix or M.prefix
	return name..'_'..uid
end


function M.makeSafe( name )
	return name:gsub( '[^%w_]', '_' )
end


function M.isSafe( name )
	return not name:match'[^%w_]'
end


function M.define( name, cdef )
	cdef = 'typedef '..cdef..' '..name..';'
	print( cdef )
	ffi.cdef( cdef )
end


function M:_included( class )
	local cdef = assert( class._cdef, 'Could not find C definition for class.' )
	local cname = class._cname or M.newUid( class._name )
	class._cname = cname
	M.define( cname, cdef )
	print( cname )
	class.allocate = ffi.metatype( cname, {} )
end


return M