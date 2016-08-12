---Sets up the environment for running init.
--see: init
local super = ... and (...):match '(.-%.?)[^%.]+$' or ''

--set up submodule paths
require'vendor'

assert( xpcall( require, require'StackTracePlus'.stacktrace, super ))