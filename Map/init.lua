--Sparse semi-random map
local Map = require'Object':extend'Map'
local MapNodeGenerator = require'MapNodeGenerator'
local Point = require'Point'

local loaderEnv = {}


function Map:get( x, y )
	return MapNodeGenerator:new( self, x, y )
end


function Map:set( v, x, y )
	self[ Point( x, y ) ] = v
end


function Map.loadFromFile( file )
	
end


return Map