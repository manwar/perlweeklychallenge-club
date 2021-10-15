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
    for i = 1, m do
        for j = 1, n do
            if seen [i * j] == nil then
                seen [i * j] = 1
                count = count + 1
            end
        end
    end
    print (count)
end
