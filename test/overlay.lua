local overlay = require'overlay'
do	--run some unsafe code
	local _ENV = overlay.overlay( _ENV )
	print"ok i can still transparently call globals"
	--try adding a new field (tests recursion)
	math.rogueFunction = error
	--overwrite a global
	print = error
	--metatable setting and the likes are not covered here
end
--ok, now test if our globals are fine
assert( not math.rogueFunction, 'ooops, the math module has been compromised' )
print'print should not error'