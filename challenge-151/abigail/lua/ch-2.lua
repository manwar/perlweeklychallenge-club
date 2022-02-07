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

    for i = #houses, 1, -1 do
        if     2 >= #houses then
            best [i] =             houses [i]
        elseif i == #houses then
            best [i] =             houses [i]
        elseif i == 0       then
            best [i] =             houses [i] + best [i + 2]
        elseif i == #houses - 1 then
            best [i] = math . max (houses [i],  best [i + 1])
        else
            best [i] = math . max (houses [i] + best [i + 2],
                                                best [i + 1])
        end
    end
    print (best [1])
end
