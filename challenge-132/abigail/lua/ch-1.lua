#!/opt/local/bin/lua

--
-- See ../README.md
--

--
-- Run as: lua ch-1.lua < input-file
--

function int (x)
    if x > 0 then
        return math . floor (x)
    else 
        return math . ceil (x)
    end
end

function g2j (Y, M, D)
    return (int ((1461 * (Y +    4800 + int ((M - 14) / 12))) /   4) +
            int ((367 * (M - 2 -   12 * int ((M - 14) / 12))) /  12) -
            int ((3 * int (((Y + 4900 + int ((M - 14) / 12))  / 100))) / 4) +
            D - 32075)
end

function j2g (J)
    local e  = 4 * (J + 1401 +
                    int (int ((4 * J + 274277) / 146097) * 3 / 4) - 38) + 3
    local D =   int (((5 * (int ((e % 1461) / 4)) + 2) % 153) / 5) + 1
    local M = ((int  ((5 * (int ((e % 1461) / 4)) + 2) / 153) + 2) % 12) + 1
    local Y = int (e / 1461) - 4716 + int ((12 + 2 - M) / 12)
    return Y, M, D
end

local julian_today  = g2j (2021, 9, 22)
local output_format = "%04d/%02d/%02d, %04d/%02d/%02d\n"

for line in io . lines () do
    local _, _, Y, M, D = line : find ("([0-9]+)/([0-9]+)/([0-9]+)")
    local julian_then = g2j (Y, M, D)
    local Y1, M1, D1 = j2g (2 * julian_then  - julian_today)
    local Y2, M2, D2 = j2g (2 * julian_today - julian_then)

    io . write (output_format : format (Y1, M1, D1, Y2, M2, D2))
end
