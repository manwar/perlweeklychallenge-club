#!/opt/local/bin/lua

--
-- See ../README.md
--

--
-- Run as: lua ch-1.lua < input-file
--

for line in io . lines () do
    local seen = {}
    local out  = 1
    for number in line : gmatch ("([-+]?[0-9]+)") do
        if seen [number] then
            out = 0  -- We have a duplicate
        else
            seen [number] = 1
        end
    end
    print (out)
end
