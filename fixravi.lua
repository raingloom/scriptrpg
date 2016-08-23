--fixes Ravi's paths
--quick hack until the PKGBUILD gets a proper patch
local function f(p)
	return p:gsub('/local','')
end
package.path=f(package.path)
package.cpath=f(package.cpath)
