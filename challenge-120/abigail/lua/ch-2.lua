#!/opt/local/bin/lua

--
-- See ../README.md
--

--
-- Run as: lua ch-2.lua < input-file
--

local DIFF_PER_MINUTE =  11
local MIN_PER_HOUR    =  60
local FULL_CIRCLE     = 720

for line in io . lines () do
    local _, _, hours, minutes = line : find ("([0-9][0-9]):([0-9][0-9])")
    hours   = tonumber (hours)
    minutes = tonumber (minutes)
    local angle = (DIFF_PER_MINUTE * (hours * MIN_PER_HOUR + minutes)) %
                                              FULL_CIRCLE
    if 2 * angle >= FULL_CIRCLE
    then angle = FULL_CIRCLE - angle
    end

    print (angle / 2)
end
