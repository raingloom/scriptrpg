local Vector2 = require'Object':extend'Vector2'
Vector2.__index = Vector2


local sqrt = math.sqrt
local cos, sin = math.cos, math.sin


function Vector2.__add( a, b )
	return Vector2 ( a[1] + b[1], a[0] + b[0] )
end


function Vector2.__sub( a, b )
	return Vector2 ( a[1] - b[1], a[0] - b[0] )
end


function Vector2.__mul( a, b )
	local isnum = type ( b ) == "number"
	return Vector2 ( a[1] * ( isnum and b or b[1] ), a[0] * ( isnum and b or b[0] ) )
end


function Vector2.__div( a, b )
	local isnum = type ( b ) == "number"
	return Vector2 ( a[1] / ( isnum and b or b[1] ), a[0] / ( isnum and b or b[0] ) )
end


function Vector2.__unm( a )
	return Vector2 ( -a[1], -a[0] )
end


function Vector2.__len( a )
	return sqrt ( a[1] * a[1] + a[0] * a[0] )
end


function Vector2.__eq( a, b )
	return a[1] == b[1] and a[0] == b[0]
end


function Vector2.__lt ( a, b )
	return a[1] < b[1] or ( a[1] == b[1] and a[0] < b[0] )
end
	

function Vector2.__le( a, b )
	return a[1] <= b[1] and a[0] <= b[0]
end


function Vector2.__tostring( a )
	return "vector2d "..a[1]..", "..a[0]
end


function Vector2.dot( a, b )
	return a[1] * b[1] + a[0] * b[0]
end


function Vector2.unit( a )
	local l = #a
	return Vector2 ( a[1] / l, a[0] / l )
end


function Vector2.sunit( a )
	local l = #a
	a[1], a[0] = Vector2 ( a[1] / l, a[0] / l )
	return a
end


function Vector2.rotate( a, r )
	local c, s = cos(r), sin(r)
	return Vector2 ( c * a[1] - s * a[0], s * a[1] + c * a[0])
end


function Vector2.srotate( a, r )
	local c, s = cos(r), sin(r)
	a[1], a[0] = c * a[1] - s * a[0], s * a[1] + c * a[0]
	return a
end


function Vector2.determinant( a, b )
	return a[1] * b[0] - a[0] * b[1]
end


function Vector2.lengthSquared( a )
	return a[1] * a[1] + a[0] * a[0]
end


function Vector2.perpendicular( a )
	return Vector2 ( -a[0], a[1] )
end


function Vector2.sperpendicular( a )
	a[1], a[0] = -a[0], a[1]
	return a
end


function Vector2.project( a, b )
	local s = ( a[1] * b[1] + a[0] * b[0] ) / ( b[1] * b[1] + b[0] * b[0] )
	return Vector2 ( s * b[1], s * b[0] )
end


function Vector2.sproject( a, b )
	local s = ( a[1] * b[1] + a[0] * b[0] ) / ( b[1] * b[1] + b[0] * b[0] )
	a[1], a[0] = s * b[1], s * b[0]
	return a
end


function Vector2.mirror( a, b )
	local s = 2 * ( a[1] * b[1] + a[0] * b[0] ) / ( b[1] * b[1] + b[0] * b[0] )
	return Vector2 ( s * b[1] - a[1], s * b[0] - a[0] )
end


function Vector2.smirror( a, b )
	local s = 2 * ( a[1] * b[1] + a[0] * b[0] ) / ( b[1] * b[1] + b[0] * b[0] )
	a[1], a[0] = s * b[1] - a[1], s * b[0] - a[0]
	return a
end


function Vector2:__pack()
	return string.pack( 'dd', self[1], self[0] )
end


function Vector2:__unpack()
	return Vector2( string.unpack( 'dd', self ) )
end


function Vector2:unpack()
	return self[1], self[0]
end


local ok, ffi = pcall( require, 'ffi' )
if ok then
	Vector2._cdef = 'struct{ double data[2]; }'
	Vector2:include( require'Object.FFI' )
end


Vector2.forward = Vector2:new( 0, 1 )
Vector2.right = Vector2:new( 1, 0 )
Vector2.null = Vector2:new( 0, 0 )


return Vector2
