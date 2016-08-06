local random = {}


function random.choice( t, s, e )
	return t[ math.random( s or 1, e or #t )]
end


function random.sample( t, n, s, e )
	local ret = {}
	s, e = s or 1, e or #t
	for i = 1, n do
		ret[ i ] = t[ math.random( s, e )]
	end
	return ret
end


return random