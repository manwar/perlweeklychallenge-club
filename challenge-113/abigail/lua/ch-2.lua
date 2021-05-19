#!/opt/local/bin/lua

--
-- See ../README.md
--

--
-- Run as: lua ch-2.lua < input-file
--

for line in io . lines () do
    local sum = 0
    for  n in line : gmatch ("-?[0-9]+")
    do   sum = sum + tonumber (n)
    end
    local c = 0
    for  n in line : gmatch ("-?[0-9]+")
    do   if   c > 0
         then io . write (" ")
         end
         c = c + 1
         io . write (sum - tonumber (n))
    end
    io . write ("\n")
end
