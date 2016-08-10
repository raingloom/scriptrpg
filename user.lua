--[[-- This file shows examples of settings you can adjust.

Configuration files with preferences are loaded in the following order:
1. cfg/user.lua (system-wide configuration)
2. HOME/.zbstudio/user.lua (per-user configuration)
3. -cfg <lua code fragment|filename> (command line configuration)

See [configuration](http://studio.zerobrane.com/doc-configuration.html) page for information about location of configuration files.

--]]--

-- to specify full path to lua interpreter if you need to use your own version
path.lua = '/usr/bin/lua5.1'
path.lua52 = '/usr/bin/lua5.2'
path.lua53 = '/usr/bin/lua'

-- to have 4 spaces when TAB is used in the editor
editor.tabwidth = 4

-- to have TABs stored in the file (to allow mixing tabs and spaces)
editor.usetabs  = true

-- to disable wrapping of long lines in the editor
editor.usewrap = false

-- to turn dynamic words on and to start suggestions after 4 characters
acandtip.nodynwords = false
acandtip.startat = 4

-- to automatically open files requested during debugging
editor.autoactivate = true
