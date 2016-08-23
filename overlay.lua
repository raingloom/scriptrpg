--FIXME: metamethods should be respected
local M = {}
M.mt = {}
--FIXME: metatables should be recursed into or transparently passed
M.mt.__metatable = false


local function mkweak()
	local t = { __mode = 'kv' }
	return setmetatable( t, t )
end
local backends = { __mode = 'k' }
setmetatable( backends, backends )
local nils = mkweak()
local recursive = mkweak()
local constructors = mkweak()


function M.overlay( t, usenil, recurse, constructor )
	local ret = setmetatable( t, M.mt )
	backends[ t ] = ret
	usenil = usenil==nil and true or usenil
	recurse = recurse==nil and true or recurse
	if usenil then
		nils[ ret ] = {}
	end
	if recurse then
		recursive[ ret ] = true
	end
	if constructor then
		constructors[ ret ] = constructor
	end
	return ret
end
	

function M.mt:__index( i )
	local backend = backends[ self ]
	local nils = nils[self]
	if nils then
		if nils[ i ] then
			return nil
		end
	end
	local v = backend[ i ]
	if type( v ) == 'table' then
		if recursive[ self ] then
			local f = constructors[ self ]
			return f and f( self, v ) or M.overlay( v )
		else
			return v
		end
	else
		return v
	end
end


function M.mt:__newindex( i, v )
	local nils = nils[ self ]
	if nils then
		nils[ i ] = v==nil or nil
	end
	rawset( self, i, v )
end


function M.mt:__pairs()
	return coroutine.wrap( function()
		local t = {}
		for k, v in next, self do
			t[ k ] = true
			coroutine.yield( k, v )
		end
		for k, v in pairs( backends[ self ]) do
			if not t[ k ] then
				coroutine.yield( k, v )
			end
		end
	end)
end


return M