#!/opt/local/bin/lua

--
-- See https://theweeklychallenge.org/blog/perl-weekly-challenge-153
--

--
-- Run as: lua ch-2.lua < input-file
--

local fac = {}
      fac [0] = 1

for n = 1, 9 do
    fac [n] = n * fac [n - 1]
end

for num in io . lines () do
    num = tonumber (num)
    local n = num
    local sum = 0
    while n > 0 do
        sum = sum + fac  [n % 10]
        n = math . floor (n / 10)
    end
    if   sum == num
    then print (1)
    else print (0)
    end
end
