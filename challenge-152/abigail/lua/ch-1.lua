#!/opt/local/bin/lua

--
-- See https://theweeklychallenge.org/blog/perl-weekly-challenge-152
--

--
-- Run as: lua ch-1.lua < input-file
--

for line in io . lines () do
    local minsum = 0
    local n      = 1
    local m      = n
    local min    = 0
    for num in line : gmatch ("-?[0-9]+") do
        num = tonumber (num)
        if (m == n) or (num < min) then
            min = num
        end
        m = m - 1
        if m == 0 then
            minsum = minsum + min
            n      = n + 1
            m      = n
            min    = 0
        end
    end
    print (minsum)
end
