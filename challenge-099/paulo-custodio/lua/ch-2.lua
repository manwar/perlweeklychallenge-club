#!/usr/bin/env lua

--[[
Challenge 099

TASK #2 › Unique Sub-sequence
Submitted by : Mohammad S Anwar
You are given two strings $S and $T.

Write a script to find out count of different unique sub-sequences matching
$T without changing the position of characters.

Example 1:
Input : $S = "littleit', $T = 'lit'
Output : 5

    1: [lit] tleit
    2: [li] t[t] leit
    3: [li] ttlei[t]
    4: litt[l] e[it]
    5: [l] ittle[it]
Example 2:
Input : $S = "london', $T = 'lon'
Output : 3

    1: [lon] don
    2: [lo] ndo[n]
    3: [l] ond[on]
--]]

function count_subsequences(s, t)
    while true do
        if t=="" then
            return 1
        elseif s=="" then
            return 0
        elseif string.sub(s,1,1)==string.sub(t,1,1) then
            return (count_subsequences(string.sub(s, 2), string.sub(t, 2)) +
                    count_subsequences(string.sub(s, 2), t))
        else
            s = string.sub(s, 2)
        end
    end
end

io.write(count_subsequences(arg[1], arg[2]))
