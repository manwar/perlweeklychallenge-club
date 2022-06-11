#!/opt/local/bin/lua

--
-- See https://theweeklychallenge.org/blog/perl-weekly-challenge-151
--

--
-- Run as: lua ch-2.lua < input-file
--

for line in io . lines () do
    local h = {}
    for val in line : gmatch ("%d+") do
        h [#h + 1] = val
    end

    h [#h + 1] = 0
    h [#h + 1] = 0

    for i = #h - 2, 3, -1 do
        h [i] = math . max (h [i] + h [i + 2], h [i + 1])
    end

    print (h [1] + h [3])
end
