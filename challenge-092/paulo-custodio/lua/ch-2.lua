#!/usr/bin/env lua

--[[
Challenge 092

TASK #2 > Insert Interval
Submitted by: Mohammad S Anwar
You are given a set of sorted non-overlapping intervals and a new interval.

Write a script to merge the new interval to the given set of intervals.

Example 1:
Input $S = (1,4), (8,10); $N = (2,6)
Output: (1,6), (8,10)
Example 2:
Input $S = (1,2), (3,7), (8,10); $N = (5,8)
Output: (1,2), (3,10)
Example 3:
Input $S = (1,5), (7,9); $N = (10,11)
Output: (1,5), (7,9), (10,11)
--]]

timeline = {}

function fill_timeline()
    for i=1,#arg do
        -- parse begin,end
        local bg, ed = string.match(arg[i], "(%d+),(%d+)")
        bg = tonumber(bg)
        ed = tonumber(ed)

        -- resize timeline if needed
        while 2*ed >= #timeline do
            table.insert(timeline, false)
        end

        -- fill interval
        for j=2*bg, 2*ed do
            timeline[j] = true
        end
    end
end

function print_timeline()
    -- collect intervals
    local intervals = {}
    for i=1, #timeline-1 do
        if timeline[i] == false and timeline[i+1] == true then
            table.insert(intervals, math.floor(i/2)+1)
        elseif timeline[i] == true and timeline[i+1] == false then
            table.insert(intervals, math.floor(i/2))
        end
    end

    -- print intervals
    for i=1, #intervals, 2 do
        io.write("(",intervals[i],",",intervals[i+1],")")
        if i+2 < #intervals then io.write(", ") end
    end
end

fill_timeline()
print_timeline()
