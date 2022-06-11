#!/opt/local/bin/lua

--
-- See https://theweeklychallenge.org/blog/perl-weekly-challenge-152
--

--
-- Run as: lua ch-2.lua < input-file
--

local i_pat = "(-?%d+)"
local pattern = i_pat
for i = 2, 8 do
    pattern = pattern .. "%s+" .. i_pat
end

for line in io . lines () do
    local _, _, a_x1, a_y1, a_x2, a_y2, b_x1, b_y1, b_x2, b_y2 =
               line : find (pattern)
    print (               (math . max (a_x1, a_x2) - math . min (a_x1, a_x2))  *
                          (math . max (a_y1, a_y2) - math . min (a_y1, a_y2))  +
                          (math . max (b_x1, b_x2) - math . min (b_x1, b_x2))  *
                          (math . max (b_y1, b_y2) - math . min (b_y1, b_y2))  -
math . max (0, math . min (math . max (a_x1, a_x2),  math . max (b_x1, b_x2))  -
               math . max (math . min (a_x1, a_x2),  math . min (b_x1, b_x2))) *
math . max (0, math . min (math . max (a_y1, a_y2),  math . max (b_y1, b_y2))  -
               math . max (math . min (a_y1, a_y2),  math . min (b_y1, b_y2))))

end
