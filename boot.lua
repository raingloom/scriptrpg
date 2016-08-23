---Sets up the environment for running init.
--see: init
local super = ... and (...):match '(.-%.?)[^%.]+$' or ''


if not _VERSION:match'5%.3$' then
	print( require'compat53' )
end


--set up submodule paths
require'vendor'

assert( xpcall( require, require'StackTracePlus'.stacktrace, super ))