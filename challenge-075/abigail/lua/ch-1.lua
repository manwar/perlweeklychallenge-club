#!/opt/local/bin/lua

--
-- See ../README.md
--

--
-- Run as: lua ch-1.lua < input-file
--

function possibilities (target, coins, from, to)
    if target == 0 then
        return 1
    end
    if target < 0 or from > to then
        return 0
    end

    local sum = 0

    for i = 0, math . floor (target / coins [from]) do
        sum = sum + possibilities (target - i * coins [from],
                                                coins, from + 1, to)
    end

    return sum
end


for line in io . lines () do
    local target
    local coins = {}
    local i
    for i in line : gmatch ("%d+") do
        if  target == nil then
            target = tonumber (i)
        else
            table . insert (coins, tonumber (i))
        end
    end
    print (possibilities (target, coins, 1, #coins))
 
end
