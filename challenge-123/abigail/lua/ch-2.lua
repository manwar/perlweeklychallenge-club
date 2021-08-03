#!/opt/local/bin/lua

--
-- See ../README.md
--

--
-- Run as: lua ch-2.lua < input-file
--

local pat = "(-?%d+)";
for _ = 2, 8 do
    pat = pat .. "%s+(-?%d+)";
end

function dist (x1, y1, x2, y2)
    return (x1 - x2) ^ 2 + (y1 - y2) ^ 2
end

for line in io . lines () do
    _, _, x1, y1, x2, y2, x3, y3, x4, y4 = line : find (pat)
    if  dist (x1, y1, x2, y2) == dist (x2, y2, x3, y3) and
        dist (x2, y2, x3, y3) == dist (x3, y3, x4, y4) and
        dist (x3, y3, x4, y4) == dist (x4, y4, x1, y1) and
        dist (x1, y1, x3, y3) == dist (x2, y2, x4, y4) then
        print (1)
    else
        print (0)
    end
end
