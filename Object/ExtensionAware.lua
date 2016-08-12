---Mixin that adds a `_subclasses` field to the class.
local Mixin = {}
local weak = require'mt'.weak


---Wraps the stock `:extend`.
function Mixin:_included( class )
	local extend = class.extend
	class._subclasses = setmetatable( {}, weak )
	---Runs the stock `:extend` and stores the resulting subclass in the `_subclasses` field.
	function class:extend( ... )
		local ret = extend( self, ... )
		self._subclasses[ ret ] = true
		ret._subclasses = setmetatable( {}, weak )
		return ret
	end
end


return Mixin
