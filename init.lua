---The main entry point.
local util = require'Object.utils'

local function animalTests( Object )
	local Animal = Object:extend'Animal'
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

	local NamedCat = Cat:extend'NamedCat'
	NamedCat:include( require'Object.MemoizedNew' )


	function NamedCat:initialize( name )
		self.name = name
	end


	function NamedCat:speak()
		return 'meow my name is '..self.name
	end


	local Mittens = NamedCat:new'Mittens'
	local Scruffy = NamedCat:new'Scruffy'
	print( Mittens:speak())
	print( Scruffy:speak())
	print( NamedCat:new'Mittens', Mittens )
end

local Object = require'Object'
local SplicedObject = require'Object.Factory':new( 'SplicedObject', require'Object.ExtensionAware', require'Object.PersistentGenealogy', require'Object.LongNames' )
animalTests( Object )
animalTests( SplicedObject )


local function factorial( n )
	return n==0 and 1 or n*factorial(n-1)
end

do
	local T = os.time
	local t = T()+1
	local i = 0
	while T()<t do
		factorial( 1024 )
		i = i + 1
	end
	print( i )
end

factorial = require'Memoizer':new( factorial )

do
	local T = os.time
	local t = T()+1
	local i = 0
	while T()<t do
		factorial( 1024 )
		i = i + 1
	end
	print( i )
end
