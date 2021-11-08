#!/opt/local/bin/lua

--
-- See ../README.md
--

--
-- Run as: lua ch-1.lua < input-file
--

for line in io . lines () do
    local result   = 0
    local seen_one = false
    for c in line : gmatch ("[0-9]") do
        result = result * 9
        if seen_one then
            result = result + 8
        elseif c == "1" then 
            seen_one = true
        elseif not (c == "0") then
            result = result + tonumber (c) - 1
        end
    end
    print (result)
end
