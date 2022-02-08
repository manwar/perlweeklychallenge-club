#!/opt/local/bin/lua

--
-- See https://theweeklychallenge.org/blog/perl-weekly-challenge-151
--

--
-- Run as: lua ch-2.lua < input-file
--

for line in io . lines () do
    local houses = {}
    local best   = {}
    for val in line : gmatch ("%d+") do
        houses [#houses + 1] = val
    end

    best [#houses + 1] = 0
    best [#houses + 2] = 0

    for i = #houses, 3, -1 do
        best [i] = math . max (houses [i] + best [i + 2], best [i + 1])
    end

    print (houses [1] + best [3])
end
