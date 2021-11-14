#!/opt/local/bin/lua

--
-- See ../README.md
--

--
-- Run as: lua ch-1.lua < input-file
--

--
-- Find the GCD, using Euclids algorithm
--    (https://en.wikipedia.org/wiki/Euclidean_algorithm#Implementations)
--
function gcd (a, b)
    if b >  a then return gcd (b, a) end
    if b == 0 then return a          end
                   return gcd (b, a % b)
end

function is_power_of_n (number, n)
    if number <  1    then return false end
    if number == 1    then return true  end
    if number % n > 1 then return false end
                      return (is_power_of_n (number / n, n))
end

function is_power_of_2 (number)
    return is_power_of_n (number, 2)
end

for line in io . lines () do
    local _, _, n, m = line : find ("([0-9]+)%s+([0-9]+)")
    n = tonumber (n)
    m = tonumber (m)
    if n % 2 == 1 or m % 2 == 1 then
        print (0)
        goto continue
    end
    local r = gcd (n, m)
    if r > 1 and is_power_of_2 (r) then
        print (1)
    else
        print (0)
    end
    ::continue::
end
