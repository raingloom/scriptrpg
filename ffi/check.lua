local M = {}


function M.external( f )
	f = io.popen( 'clang -o /dev/null '..f..' 2>&1', 'r' )
	local ret = f:read'a'
	f:close()
	return ret
end


function M.check( cdef )
	local tmpn = os.tmpname()..'.h'
	local tmpf = assert( io.open( tmpn, 'w' ))
	tmpf:write( cdef )
	local ret = M.external( tmpn )
	print( ret )
end


function M.register( ffi )
	ffi = ffi or require'ffi'
	local cdef = ffi.cdef
	function ffi.cdef( ... )
		local ret = M.check( ... )
		cdef( ... )
		return ret
	end
end


return M