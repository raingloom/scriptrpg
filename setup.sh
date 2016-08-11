local base = `dirname $0`
curl http://keplerproject.github.io/luarocks/releases/luarocks-2.3.0.tar.gz > "$base/luarocks-src.tar.gz"
tar xvuf "$base/luarocks-src.tar.gz"