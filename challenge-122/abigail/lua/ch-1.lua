#!/opt/local/bin/lua

--
-- See ../README.md
--

--
-- Run as: lua ch-1.lua < input-file
--

local s = 0
local c = 0

for n in io . lines () do
    s = s + tonumber (n)
    c = c + 1
    print (s / c)
end
