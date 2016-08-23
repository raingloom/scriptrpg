local ok, ffi = pcall( require, 'ffi' )
ffi = ok and ffi
local Point = require'Object':extend( 'Point' )


return Point