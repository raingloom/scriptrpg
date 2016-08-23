---This mixin memoizes the `:extend` method of a class, so using it with the same parameters will return the exact same object.
local Mixin = {}

local Memoizer = require'Memoizer'


function Mixin:_included( class )
	class.new = Memoizer:new( class.new ):wrap()
end


return Mixin