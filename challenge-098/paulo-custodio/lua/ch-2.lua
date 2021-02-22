#!/usr/bin/env lua

--[[
Challenge 098

TASK #2 › Search Insert Position
Submitted by: Mohammad S Anwar
You are given a sorted array of distinct integers @N and a target $N.

Write a script to return the index of the given target if found
otherwise place the target in the sorted array and return the index.

Example 1:
Input: @N = (1, 2, 3, 4) and $N = 3
Output: 2 since the target 3 is in the array at the index 2.
Example 2:
Input: @N = (1, 3, 5, 7) and $N = 6
Output: 3 since the target 6 is missing and should be placed at
the index 3.
Example 3:
Input: @N = (12, 14, 16, 18) and $N = 10
Output: 0 since the target 10 is missing and should be placed at
the index 0.
Example 4:
Input: @N = (11, 13, 15, 17) and $N = 19
Output: 4 since the target 19 is missing and should be placed at
the index 4.
--]]


-- search for index of element, insert in array if not found
function search_insert(nums, n)
    local b = 1
    local t = #nums
    if t < b then               -- empty
        table.insert(nums, n)
        return 0
    elseif n < nums[b] then     -- before first
        table.insert(nums, 1, n)
        return 0
    elseif n > nums[t] then     -- after last
        table.insert(nums, n)
        return #nums-1
    else
        local m = math.floor((t+b)/2)
        while b+1 < t do        -- bisect loop
            if n == nums[m] then
                return m-1
            elseif n < nums[m] then
                t = m
            else
                b = m
            end
            m = math.floor((t+b)/2)
        end
        table.insert(nums, m+1, n)  -- not found, insert
        return m
    end
end

n = arg[1]
nums = {}
for i=2, #arg do
    table.insert(nums, arg[i])
end

p = search_insert(nums, n)
io.write(p, "\n")

io.write("(")
sep = ""
for i=1, #nums do
    io.write(sep, nums[i])
    sep = ", "
end
io.write(")\n")
