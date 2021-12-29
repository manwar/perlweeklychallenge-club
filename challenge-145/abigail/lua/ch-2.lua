#!/opt/local/bin/lua

--
-- See ../README.md
--

--
-- Run as: lua ch-2.lua < input-file
--

for line in io . lines () do
    local palindromes = {}
    local out = ""
    for i = 1, #line do
        for j = i, #line do
            local string = line : sub (i, j)
            if string == string : reverse () then
                if palindromes [string] == nil
                then out = out .. string .. " "
                     palindromes [string] = 1
                end
            end
        end
    end
    print (out : sub (1, #out - 1))
end
