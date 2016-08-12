---Provides persistent information about class hierarchy that cannot be overridden by custom `_super` fields.
--When `included`, this mixin wraps the `:extend` method of the target class.
--see: _included
--see: Object:include
local M = {}
local weak = require'mt'.weak
---`child->parent` indexed table
M.uptree = setmetatable({},weak)
---`parent->children` indexed table
M.downtree = setmetatable({},weak)


---Wraps the `:extend` method on `class`, so that it stores the parent and child class in this module.
--param: class the class to modify
function M:_included( class )
	local oldextend = class.extend
	function class:extend( ... )
		local ret = oldextend( self, ... )
		M.uptree[ret] = self
		local t = M.downtree[self]
		if not t then
			t = {}
			M.downtree[self] = t
		end
		table.insert( t, ret )
		return ret
	end
end


return M