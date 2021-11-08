#!/usr/bin/env lua

--[[
Challenge 120

TASK #2 - Clock Angle
Submitted by: Mohammad S Anwar
You are given time $T in the format hh:mm.

Write a script to find the smaller angle formed by the hands of an analog
clock at a given time.

HINT: A analog clock is divided up into 12 sectors. One sector represents 30
degree (360/12 = 30).

Example
Input: $T = '03:10'
Output: 35 degree

The distance between the 2 and the 3 on the clock is 30 degree.
For the 10 minutes i.e. 1/6 of an hour that have passed.
The hour hand has also moved 1/6 of the distance between the 3 and the 4,
which adds 5 degree (1/6 of 30).
The total measure of the angle is 35 degree.

Input: $T = '04:00'
Output: 120 degree
--]]

function split(inputstr, sep)
    if sep == nil then
        sep = "%s"
    end
    local t = {}
    for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
        table.insert(t, str)
    end
    return t
end

function parse_time(hhmm)
    local a = split(hhmm, ":")
    local hh = tonumber(a[1])
    local mm = tonumber(a[2])
    return hh, mm
end

function clock_angles(hh, mm)
    local mm_angle = math.floor(mm*360/60)
    local hh_angle = math.floor((hh % 12)*360/12) + math.floor(mm_angle/12)
    return hh_angle, mm_angle
end

function clock_angle(hh, mm)
    local hh_angle, mm_angle = clock_angles(hh, mm)
    local angle = math.abs(hh_angle - mm_angle)
    if angle > 180 then angle = 360 - angle end
    return angle
end

hh, mm = parse_time(arg[1])
angle = clock_angle(hh, mm)
io.write(angle, "\n")
