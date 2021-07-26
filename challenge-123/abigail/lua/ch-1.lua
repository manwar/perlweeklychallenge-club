#!/opt/local/bin/lua

--
-- See ../README.md
--

--
-- Run as: lua ch-1.lua < input-file
--

local ugly = {}
ugly [1] = 1
local next_2 = 1
local next_3 = 1
local next_5 = 1
local count  = 1

for n in io . lines () do
    n = tonumber (n)
    while count < n do
        local c2 = 2 * ugly [next_2]
        local c3 = 3 * ugly [next_3]
        local c5 = 5 * ugly [next_5]

        count = count + 1

        if c2 <= c3 and c2 <= c5 then
            ugly [count] = c2
        end
        if c3 <= c2 and c3 <= c5 then
            ugly [count] = c3
        end
        if c5 <= c2 and c5 <= c3 then
            ugly [count] = c5
        end

        if 2 * ugly [next_2] <= ugly [count] then
            next_2 = next_2 + 1
        end
        if 3 * ugly [next_3] <= ugly [count] then
            next_3 = next_3 + 1
        end
        if 5 * ugly [next_5] <= ugly [count] then
            next_5 = next_5 + 1
        end
    end
    print (ugly [n])
end
