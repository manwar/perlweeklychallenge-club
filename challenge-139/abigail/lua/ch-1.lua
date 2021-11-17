#!/opt/local/bin/lua

--
-- See ../README.md
--

--
-- Run as: lua ch-1.lua < input-file
--

for line in io . lines () do
    local sorted = 1
    local prev   = nil
    for next in line : gmatch ("[0-9]+") do
        if prev ~= nil and prev > next then
            sorted = 0
        end
        prev = next
    end
    print (sorted)
end
