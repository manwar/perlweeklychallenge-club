#!/usr/bin/env lua

--[[
Challenge 097

TASK #2 › Binary Substings
Submitted by: Mohammad S Anwar
You are given a binary string $B and an integer $S.

Write a script to split the binary string $B of size $S and then find the
minimum number of flips required to make it all the same.

Example 1:
Input: $B = “101100101”, $S = 3
Output: 1

Binary Substrings:
    "101": 0 flip
    "100": 1 flip to make it "101"
    "101": 0 flip
Example 2:
Input $B = “10110111”, $S = 4
Output: 2

Binary Substrings:
    "1011": 0 flip
    "0111": 2 flips to make it "1011"
--]]

function str_flips(a, b)
    local flips = 0
    for i=1,#a do
        if string.sub(a,i,i) ~= string.sub(b,i,i) then
            flips = flips+1
        end
    end
    return flips
end

function bit_flips(bits, n)
    local flips = 0
    for i=n+1,#bits,n do
        flips = flips+str_flips(string.sub(bits,1,1+n-1),
                                string.sub(bits,i,i+n-1))
    end
    return flips
end

io.write(bit_flips(arg[1], arg[2]),"\n")
