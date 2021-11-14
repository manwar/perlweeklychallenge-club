#!/opt/local/bin/lua

--
-- See ../README.md
--

--
-- Run as: lua ch-1.lua < input-file
--

local SUNDAY    = 0
local MONDAY    = 1
local TUESDAY   = 2
local WEDNESDAY = 3
local THURSDAY  = 4
local FRIDAY    = 5
local SATURDAY  = 6

local lookup    = {
    {261, 260, 260, 261, 261, 261, 261},
    {262, 261, 260, 261, 262, 262, 262},
}

local anchors   = {TUESDAY, SUNDAY, FRIDAY, WEDNESDAY}

function doomsday (year)
    local anchor = anchors [1 + math . floor (year / 100) % 4]
    local y      = year % 100
    return ((math . floor (y / 12) + (y % 12) + math . floor ((y % 12) / 4)) +
             anchor) % 7
end

function is_leap (year)
    if (year % 400 == 0) or ((year % 4 == 0) and (year % 100 ~= 0)) then
        return 1
    end
    return 0
end


for year in io . lines () do
    year = tonumber (year)
    print (lookup [1 + is_leap (year)] [1 + doomsday (year)])
end
