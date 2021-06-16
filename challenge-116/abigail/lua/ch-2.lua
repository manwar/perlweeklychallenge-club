#!/opt/local/bin/lua

--
-- See ../README.md
--

--
-- Run as: lua ch-2.lua < input-file
--

for line in io . lines () do
    local sum_of_squares = 0
    for d in line : gmatch ("%d") do
        local number = tonumber (d)
        sum_of_squares = sum_of_squares + number * number
     end
     root = math . floor (.5 + math . sqrt (sum_of_squares))
     if   sum_of_squares == root * root
     then print (1)
     else print (0)
     end
end
