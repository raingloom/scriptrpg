local Object = { _id = 1, _name = 'Object' }
Object.__index = Object


function Object:new( ... )
	local ret = self:allocate( ... )
	ret:initialize( ... )
	return ret
end


function Object:allocate( ... )
	local id = self._id
	self._id = id + 1
	return setmetatable( { _class = self, _id = id }, self )
end


function Object:initialize( ... )
end


--[=[
--[[--
	Copy the object instance or the class. This is a deep copy.
	@param t the table to copy into (optional)
	@return deep copy
]]
function Object:copy( t )
	t = t or {}
	for k, v in pairs( self ) do
		t[ k ] = v
	end
	return t
end
]=]


function Object:__tostring()
	return self._class._name..'<'..self._id..'>'
end


function Object:extend( name, copy )
	assert( not self._class, 'Can\'t call a class method on an object' )
	local ret = { _super = self }
	for k, v in pairs( self ) do
		if copy or k:sub( 1, 2 ) == '__' then
			ret[ k ] = v
		end
	end
	ret.__index = ret
	ret._name = name or 'AnonymousClass('..tostring( ret )..')'
	return setmetatable( ret, { __index = self } )
end


function Object:is( class )
	return self._class == class
end


function Object:implement( ... )
	for _, mixin in ipairs{...} do
		if mixin.__implement then
			mixin:__implement( self )
		else
			for k, v in pairs( mixin ) do
				self[ k ] = v
			end
		end
	end
end


function Object:isSubclassOf( class )
	while self._super do
		if self._super == class then
			return true
		end
		self = self._super
	end
	return false
end


return Object