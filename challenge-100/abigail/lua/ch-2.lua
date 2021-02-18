#!/opt/local/bin/lua

--
-- See ../README.md
--

--
-- Run as: lua ch-2.lua < input-file
--

local numbers = {}

--
-- Read in the data
--
for line in io . lines () do
    local row = {}
    for n in line : gsub ("\n", "") : gmatch ("-?%d+") do
        table . insert (row, n)
    end
    table . insert (numbers, row)
end

--
-- Calculate minimum path, bottom to top
--
for x = #numbers - 1, 1, -1 do
    local row = numbers [x]
    for y = 1, #row do
        min =      numbers [x + 1] [y]
        if         numbers [x + 1] [y + 1] < min
        then min = numbers [x + 1] [y + 1]
        end
        numbers [x] [y] = numbers [x] [y] + min
    end 
end

--
-- Print result
--
print (numbers [1] [1])
