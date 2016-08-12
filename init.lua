---The main entry point.
local util = require'Object.utils'
local Animal = require'Object':extend'Animal'
local Cat = Animal:extend'Cat'
local Dog = Animal:extend'Dog'


function Animal:speak()
	return 'idk what to say'
end


function Cat:speak()
	return 'meow'
end


function Dog:speak()
	return 'woof'
end


print( Animal:new():speak())
print( Animal:extend():new())
print( Cat:new():speak())
print( Dog:new():speak())
print( util.properName( Dog ))