local Mixin = {}
local weak = require'mt'.weak


function Mixin:__implement( class )
	local extend = class.extend
	class._subclasses = setmetatable( {}, weak )
	function class:extend( ... )
		local ret = extend( self, ... )
		self._subclasses[ ret ] = true
		ret._subclasses = setmetatable( {}, weak )
		return ret
	end
end


return Mixin