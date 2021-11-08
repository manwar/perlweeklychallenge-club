#!/opt/local/bin/lua

--
-- See ../README.md
--

--
-- Run as: lua ch-2.lua
--

local small_primes = {2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31}

function factorize (num)
    local out = {}
    for _, prime in ipairs (small_primes) do
        while num % prime == 0 do
            table . insert (out, prime)
            num = num / prime
        end
    end
    if num > 1 then
        table . insert (out, num)
    end
    return (out)
end


function digit_sum (numbers)
    local sum = 0
    for _, number in pairs (numbers) do
        while number > 0 do
            sum = sum + number % 10
            number = math . floor (number / 10)
        end
    end
    return (sum)
end


local number = 1
local count  = 0


while count < 10 do
    local factors = factorize (number)
    if #factors > 1 then
        if digit_sum ({number}) == digit_sum (factors) then
            print (number)
            count = count + 1
        end
    end
    number = number + 1
end
