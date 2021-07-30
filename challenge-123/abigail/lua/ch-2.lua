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


for line in io . lines () do
    _, _, x1, y1, x2, y2, x3, y3, x4, y4 = line : find (pat)
    local e1 = (x1 - x2) ^ 2 + (y1 - y2) ^ 2
    local e2 = (x2 - x3) ^ 2 + (y2 - y3) ^ 2
    local e3 = (x3 - x4) ^ 2 + (y3 - y4) ^ 2
    local e4 = (x4 - x1) ^ 2 + (y4 - y1) ^ 2
    local d1 = (x1 - x3) ^ 2 + (y1 - y3) ^ 2
    local d2 = (x2 - x4) ^ 2 + (y2 - y4) ^ 2
    if  e1 == e2 and e2 == e3 and e3 == e4 and d1 == d2 then
        print (1)
    else
        print (0)
    end
end
