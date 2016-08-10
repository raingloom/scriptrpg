--Sparse semi-random map
local Map = require'Object':extend'Map'
local Generator = require'Map.Node.Generator'
local Point = require'Point'

local loaderEnv = {}


function Map:get( x, y )
	return Generator:new( self, x, y )
end


function Map:set( v, x, y )
	self[ Point:new( x, y ) ] = v
end


function Map.loadFromFile( file )
	
end


return Map