#!/usr/bin/env lua

--[[
Challenge 099

TASK #1 › Pattern Match
Submitted by: Mohammad S Anwar
You are given a string $S and a pattern $P.

Write a script to check if given pattern validate the entire string.
Print 1 if pass otherwise 0.

The patterns can also have the following characters:

? - Match any single character.
* - Match any sequence of characters.
Example 1:
Input: $S = "abcde" $P = "a*e"
Output: 1
Example 2:
Input: $S = "abcde" $P = "a*d"
Output: 0
Example 3:
Input: $S = "abcde" $P = "?b*d"
Output: 0
Example 4:
Input: $S = "abcde" $P = "a*c?e"
Output: 1
--]]

function match(s, p)
    while true do
        if s=="" and p=="" then
            return true
        elseif s=="" or p=="" then
            return false
        elseif string.sub(p,1,1)=="?" then
            s = string.sub(s, 2)
            p = string.sub(p, 2)
        elseif string.sub(p,1,1)=="*" then
            p = string.sub(p, 2)
            for i=2,#s do
                if match(string.sub(s,i), p) then
                    return true
                end
            end
            return false
        elseif string.sub(s,1,1)~=string.sub(p,1,1) then
            return false
        else
            s = string.sub(s, 2)
            p = string.sub(p, 2)
        end
    end
end

if match(arg[1], arg[2]) then
    io.write(1, "\n")
else
    io.write(0, "\n")
end
