#!/usr/bin/env lua

--[[
Challenge 092

TASK #1 > Isomorphic Strings
Submitted by: Mohammad S Anwar
You are given two strings $A and $B.

Write a script to check if the given strings are Isomorphic. Print 1 if they
are otherwise 0.

Example 1:
Input: $A = "abc"; $B = "xyz"
Output: 1
Example 2:
Input: $A = "abb"; $B = "xyy"
Output: 1
Example 3:
Input: $A = "sum"; $B = "add"
Output: 0
--]]

function split_string(str)
    local t = {}
    string.gsub(str, ".", function(c) table.insert(t,c) end)
    return t
end

function isomorphic(a, b)
    if #a ~= #b then
        return 0
    else
        local a = split_string(a)
        local b = split_string(b)
        local mapping = {}
        local mapped = {}

        for i=1, #a do
            if mapping[a[i]] == nil then        -- a is new
                if mapped[b[i]] ~= nil then     -- b already mapped to some other a
                    return 0
                else                            -- store mapping
                    mapping[a[i]] = b[i]
                    mapped[b[i]] = 1
                end
            else                                -- a already occurred
                if mapping[a[i]] ~= b[i] then   -- previous mapping is different
                    return 0
                end
            end
        end
        return 1
    end
end

io.write(isomorphic(arg[1], arg[2]))
