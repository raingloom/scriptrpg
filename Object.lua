local Object = { _id = 1, _name = 'Object' }


function Object:new( ... )
	return self:allocate( ... ):initialize( ... )
end


function Object:allocate( ... )
	local id = self._id
	self._id = id + 1
	return setmetatable( { _class = self, _id = id }, self )
end


function Object:new( ... )
end


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