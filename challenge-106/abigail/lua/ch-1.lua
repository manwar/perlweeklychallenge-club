#!/opt/local/bin/lua

--
-- See ../README.md
--

--
-- Run as: lua ch-1.lua < input-file
--

for line in io . lines () do
    --
    -- Extract the numbers from the line of input
    -- Note that gmatch() doesn't return an array or list;
    -- we have to iterate over it, and construct an array
    --
    local numbers = {}
    for i in line : gmatch ("(%S+)") do
        numbers [#numbers + 1] = i
    end

    --
    -- Sort it; the default sort is numerical
    --
    table . sort (numbers)

    --
    -- Find the max difference
    --
    local max = 0
    for i, n in ipairs (numbers) do
        if (i > 1 and (numbers [i] - numbers [i - 1]) > max)
        then max = numbers [i] - numbers [i - 1]
        end
    end

    --
    -- And print it
    --
    print (max)
end
