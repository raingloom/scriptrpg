--[[--
	A class factory used for building custom OOP models. Uses mixins and memoization to allow sharing the resulting classes.
]]
--TODO: ORDER OF MIXINS SHOULD NOT MATTER!!!
local Object = require'Object'
local Factory = Object:extend'ClassFactory'
local MemoizedNew = require'Object.MemoizedNew'


function Factory:new( name, ... )
	local class = Object:extend( name )
	class:include( ... )
	return class
end


Factory:include( MemoizedNew )


return Factory