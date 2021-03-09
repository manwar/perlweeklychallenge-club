#!/usr/bin/env lua

--[[
Challenge 102

TASK #1 › Rare Numbers
Submitted by: Mohammad S Anwar

You are given a positive integer $N.

Write a script to generate all Rare numbers of size $N if exists. Please
checkout the page for more information about it.
Examples

(a) 2 digits: 65
(b) 6 digits: 621770
(c) 9 digits: 281089082
--]]

function perfect_square(n)
    local sq = math.sqrt(n)
    if math.floor(sq) == sq then
        return true
    else
        return false
    end
end

function print_rare(n)
    for r=10^(n-1),(10^n)-1 do
        r = math.floor(r)           -- convert to int
        r1 = tonumber(string.reverse(tostring(r)))
        if perfect_square(r+r1) then
            if r >= r1 then
                if perfect_square(r-r1) then
                    io.write(r, "\n")
                end
            end
        end
    end
end

print_rare(tonumber(arg[1]))
