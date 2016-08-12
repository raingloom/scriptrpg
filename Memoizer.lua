---A memoization module that should work for any vararg and multi-return function you throw at it.
local Memoizer = require'Object':extend'Memoizer'
--[[--
	Demo:
	```
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
	```
]]
--[[
	Although not visible to the end user, this special value allows two things: storing `nil` returns and arguments and marking cache storage thus separating it from tables returned by the wrapped function. When searching the cache tree, tables that have `NIL` as their metatable are known to be cache results. This way the retrieval algorithm knows that it should not return that as a result, but return `nil` instead. Without this feature calling `f(1,2)` would store a table such like: `t={[1]={[2]={'result',n=1}}}` and a later call like `f(1)` would search the tree up until `t[1]` and find a table already there, then it would assume that is a result of a previous call and return it. This is especially terrible if you must run untrusted code as it could lead to disclosure of sensitive data.
]]
local NIL = {'NIL'}


---Calling the object should be the same as calling the function itself.
function Memoizer:__call( ... )
	local ret = self:get( ... )--check if we already have it in the cache tree
	if ret==nil then
		--if not, call self again
		ret = table.pack( self.func( ... ))
		for i = 1, ret.n do
			--filter nils and replace them with NIL, this is needed for indexing as you can't use nil as an index
			local v = ret[i]
			if v==nil then
				ret[i] = NIL
			end
		end
		--store the returned value
		self:set( ret, ... )
	end
	return table.unpack( ret, 1, ret.n )
end


---Retrieve a previously stored value.
function Memoizer:get( ... )
	local arg = table.pack( ... )
	local cache = self.cache
	for i = 1, arg.n do
		--filter nils here too
		--TODO: this could be removed to avoid double iteration. Since `:get` and `:set` are pointless if all we want is seamless caching and `:clean()` we should be able to either inline them or construct them to avoid nil filtering.
		local a = arg[ i ]
		if a==nil then
			a = NIL
		end
		cache = cache[ a ]
		if cache==nil then
			return nil
		end
	end
	return getmetatable( cache ) ~= NIL and cache or nil
end


---Ascends the cache tree - building branches as needed - and stores a value in it.
--Optionally, this could be used to trim branches.
function Memoizer:set( v, ... )
	local cache = self.cache
	local arg = table.pack( ... )
	for i = 1, arg.n-1 do
		--TODO: same as `:get()`, this function needs optimisation
		local a = arg[ i ]
		if a==nil then
			a = NIL
		end
		local c = cache[ a ]
		if c==nil then
			c = setmetatable( {}, NIL )--mark the table so vararg functions can't access the cache tree
			cache[ a ] = c
		end
		cache = c
	end
	local a = arg[ arg.n ]
	if a==nil then
		a = NIL
	end
	cache[ a ] = v
end
	

function Memoizer:initialize( f, weak )
	self.cache = setmetatable( {}, NIL )
	self.func = f
end


---Deletes the cache
function Memoizer:clear()
	self.cache = setmetatable( {}, NIL )
end


function Memoizer:wrap()
	return function( ... )
		return self( ... )
	end
end


return Memoizer