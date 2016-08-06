local Object = require'Object'


local Animal = Object:extend'Animal'
assert( Animal._name == 'Animal' )