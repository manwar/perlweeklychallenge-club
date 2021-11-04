#!/opt/local/bin/lua

--
-- See ../README.md
--

--
-- Run as: lua ch-1.lua < input-file
--

for num in io . lines () do
    print (math . floor (math . exp (math . log (tonumber (num)) / 2)))
end
