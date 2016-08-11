local Object = require'Object':extend'ClassFactory'
local Memoizer = require'Memoizer'


function Object:new( name, ... )
	
end


Object.implementor = Memoizer:new( Object.implement )


return Object