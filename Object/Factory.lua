--[[--
	A class factory used for building custom OOP models. Uses mixins and memoization to allow sharing the resulting classes.
]]
--TODO: ORDER OF MIXINS SHOULD NOT MATTER!!!
local Object = require'Object':extend'ClassFactory'
local Memoizer = require'Memoizer'


function Object:new( name, ... )
	
end


Object.implementor = Memoizer:new( Object.implement )


return Object