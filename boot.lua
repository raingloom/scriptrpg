local super = ... and (...):match '(.-%.?)[^%.]+$' or ''

--set up submodule paths
require'vendor'

assert( xpcall( require, require'StackTracePlus'.stacktrace, super ))