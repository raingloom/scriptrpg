local vendorPath = package.searchpath( ..., package.path )

local buf, i = {}, 1
for _,s in pairs{
	'?.lua',
	'?/init.lua',
	'?/?.lua',
	'?/src/?.lua',
	'?/src/init.lua',
} do
	buf[ i ], i = vendorPath..s, i + 1
end
package.path = package.path .. ';' .. table.concat( buf, ';' )
