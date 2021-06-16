#!/opt/local/bin/lua

--
-- See ../README.md
--

--
-- Run as: lua ch-2.lua < input-file
--

function steps (x, y, path)
    if   x == 0 and y == 0
    then print (path)
         return
    end
    if  x > 0
    then steps (x - 1, y,     path .. "R")
         steps (x - 1, y + 1, path .. "L")
    end
    if  y > 0
    then steps (x,     y - 1, path .. "H")
    end
end


steps (tonumber (io . read ()), 0, "")
