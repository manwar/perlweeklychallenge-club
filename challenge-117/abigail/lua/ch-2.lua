#!/opt/local/bin/lua

--
-- See ../README.md
--

--
-- Run as: lua ch-2.lua < input-file
--

function steps (x, y, prefix)
    if   x == 0 and y == 0
    then print (prefix)
         return
    end
    if  x > 0
    then steps (x - 1, y,     prefix .. "R")
         steps (x - 1, y + 1, prefix .. "L")
    end
    if  y > 0
    then steps (x,     y - 1, prefix .. "H")
    end
end


steps (tonumber (io . read ()), 0, "")
