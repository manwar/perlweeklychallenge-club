#!/opt/local/bin/lua

--
-- See ../README.md
--

--
-- Run as: lua ch-2.lua < input-file
--

for line in io . lines () do
    local _, _, m, n = line : find ("([0-9]+)%s+([0-9]+)")
    local seen = {}
    local count = 0
    for x = 1, m do
        for y = 1, n do
            if seen [x * y] == nil then
                seen [x * y] = 1
                count = count + 1
            end
        end
    end
    print (count)
end
