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

--
-- Precalculate all the relevant powers of 2. Note that in pre 5-3 lua
-- integers are doubles, and start losing precision at 2^53, so we go
-- up to 2^52.
--
local power_of_2 = {}
local power      = 1
for i = 1, 52 do
    power = power * 2
    power_of_2 [power] = 1
end


for line in io . lines () do
    local _, _, n, m = line : find ("([0-9]+)%s+([0-9]+)")
    if power_of_2 [gcd (tonumber (n), tonumber (m))] then
        print (1)
    else
        print (0)
    end
end
