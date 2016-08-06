local MapNode = require'MapNode'
local MapNodeGenerator = require'Object':extend'MapNodeGenerator'


function MapNodeGenerator:new( k )
	return MapNode
end


return MapNodeGenerator