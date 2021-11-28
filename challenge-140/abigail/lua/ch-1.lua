#!/opt/local/bin/lua

--
-- See ../README.md
--

--
-- Run as: lua ch-1.lua < input-file
--

function dec2bin (dec)
    local bin = {}
    local out = ""
    while dec > 0 do
        bin [#bin + 1] = dec % 2
        dec = math . floor (dec / 2)
    end
    for i = #bin, 1, -1 do
        out = out .. bin [i]
    end
    return out
end


for line in io . lines () do
    _, _, a, b = line : find ("([01]+)%s+([01]+)")
    print (dec2bin (tonumber (a, 2) + tonumber (b, 2)))
end
