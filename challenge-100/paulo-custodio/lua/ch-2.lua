#!/usr/bin/env lua

--[[
Challenge 100

TASK #2 > Triangle Sum
Submitted by: Mohammad S Anwar
You are given triangle array.

Write a script to find the minimum path sum from top to bottom.

When you are on index i on the current row then you may move to either
index i or index i + 1 on the next row.

Example 1:
Input: Triangle = [ [1], [2,4], [6,4,9], [5,1,7,2] ]
Output: 8

Explanation: The given triangle

            1
           2 4
          6 4 9
         5 1 7 2

The minimum path sum from top to bottom:  1 + 2 + 4 + 1 = 8

             [1]
           [2]  4
           6 [4] 9
          5 [1] 7 2
Example 2:
Input: Triangle = [ [3], [3,1], [5,2,3], [4,3,1,3] ]
Output: 7

Explanation: The given triangle

            3
           3 1
          5 2 3
         4 3 1 3

The minimum path sum from top to bottom: 3 + 1 + 2 + 1 = 7

             [3]
            3  [1]
           5 [2] 3
          4 3 [1] 3
--]]

triangle = {}

function add_row(row, text)
    rows = row
    table.insert(triangle, {})
    for i=1, row do
        local s, e = string.find(text, "(%d+)")
        local n = tonumber(string.sub(text, s, e))
        text = string.sub(text, e+1, -1)
        table.insert(triangle[row], n)
    end
end

function min_sum(sum, row, col)
    sum = sum or 0
    row = row or 1
    col = col or 1
    sum = sum + triangle[row][col]
    if row == rows then
        return sum
    else
        local sum1 = min_sum(sum, row+1, col)
        local sum2 = min_sum(sum, row+1, col+1)
        return math.min(sum1, sum2)
    end
end

for i=1, #arg do
    add_row(i, arg[i])
end
io.write(min_sum(), "\n")
