local Mixin = {}
local utils = require'Object.utils'


function Mixin:_included( class )
	local oldextend = class.extend
	function class:extend( ... )
		local ret = oldextend( class, ... )
		ret._name = utils.properName( ret )
		return ret
	end
end


return Mixin