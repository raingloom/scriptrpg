local MapNode = require'Object.ExtensionAware':extend'MapNode'


function MapNode:new( neighbours )
	self.neighbours = neighbours
end


return MapNode