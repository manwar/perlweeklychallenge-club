#!/opt/local/bin/lua

--
-- See ../README.md
--

--
-- Run as: lua ch-2.lua < input-file
--

function can_split (target, number)
    if target >  number or target < 0 then
        return false
    end
    if target == number then
        return true
    end

    local pow_10 = 10

    while pow_10 <= number do
        if can_split (target - (number % pow_10),
                  math . floor (number / pow_10)) then
            return true
        end
        pow_10 = pow_10 * 10
    end

    return false
end

for number in io . lines () do
    number = tonumber (number)
    if number > 1 and
       can_split (math . floor (math . sqrt (number)), number) then
        print (1)
    else
        print (0)
    end
end
