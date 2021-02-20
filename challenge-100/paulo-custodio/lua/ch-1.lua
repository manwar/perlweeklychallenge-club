#!/usr/bin/env lua

--[[
Challenge 100

TASK #1 > Fun Time
Submitted by: Mohammad S Anwar
You are given a time (12 hour / 24 hour).

Write a script to convert the given time from 12 hour format to 24 hour format
and vice versa.

Ideally we expect a one-liner.

Example 1:
Input: 05:15 pm or 05:15pm
Output: 17:15
Example 2:
Input: 19:15
Output: 07:15 pm or 07:15pm
--]]

function convert_time(text)
    text = string.lower(text)
    local hour, minute = string.match(text, "(%d+):(%d+)")
    hour = tonumber(hour)
    minute = tonumber(minute)
    local am = string.match(text, "am")
    local pm = string.match(text, "pm")
    if am or pm then
        -- 12->24
        if pm then
            if hour < 12 then
                hour = hour + 12
            end
        else
            if hour == 12 then
                hour = 0
            end
        end
        return string.format("%02d:%02d", hour, minute)
    else
        -- 24->12
        local ampm = "am"
        if hour == 0 then
            hour = 12
        elseif hour == 12 then
            ampm = "pm"
        elseif hour > 12 then
            hour = hour - 12
            ampm = "pm"
        end
        return string.format("%02d:%02d%s", hour, minute, ampm)
    end
end

io.write(convert_time(arg[1]))
