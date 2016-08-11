local M = {}


function M.superclasses( class )
	return function()
		if class then
			class = class._super
		end
		return class
	end
end


function M.isSubclassOf( class )
	for sup in M.superclasses( class ) do
		if sup == class then
			return true
		end
	end
	return false
end


function M.properName( class )
	local buf, i = { class._name }, 2
	for sup in M.superclasses( class ) do
		buf[ i ], i = sup._name, i + 1
	end
	for j = 1, i//2 do
		i = i - 1
		buf[j], buf[i] = buf[i], buf[j]
	end
	return table.concat( buf, '.' )
end


return M