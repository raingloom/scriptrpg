local ExtensionAwareObject = require'Object':extend'ExtensionAwareObject'


local extend = ExtensionAwareObject.extend
local weak = require'mt'.weak
ExtensionAwareObject._subclasses = setmetatable( {}, weak )
function ExtensionAwareObject:extend( ... )
	local ret = extend( self, ... )
	self._subclasses[ ret ] = true
	ret._subclasses = setmetatable( {}, weak )
	return ret
end


return ExtensionAwareObject