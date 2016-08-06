local MapNode = require'ExtensionAwareObject':extend'MapNode'


function MapNode:new( neighbours )
	self.neighbours = neighbours
end


return MapNode