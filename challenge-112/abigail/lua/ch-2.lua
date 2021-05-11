#!/opt/local/bin/lua

--
-- See ../README.md
--

--
-- Run as: lua ch-2.lua < input-file
--

local SQRT5 = math . sqrt (5)
local PHI   = (1 + SQRT5) / 2

for line in io . lines () do
    print (math . floor (0.5 + PHI ^ (tonumber (line) + 1) / SQRT5))
end
