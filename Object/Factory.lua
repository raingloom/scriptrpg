local Object = require'Object':extend'OOP Factory'
local Memoizer = require'Memoizer'


function Object:new( ... )
	return cachedImplement( self, ... )
end


Object.implementor = Memoizer:new( Object.implement )


return Object