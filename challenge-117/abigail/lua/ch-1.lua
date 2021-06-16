#!/opt/local/bin/lua

--
-- See ../README.md
--

--
-- Run as: lua ch-1.lua < input-file
--

local SUM_15 = 120
local sum = 0
for line in io . lines () do
    sum = sum + tonumber (line : match ("%d+"))
end
print (SUM_15 - sum)
