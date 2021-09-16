#!/opt/local/bin/lua

--
-- See ../README.md
--

--
-- Run as: lua ch-1.lua < input-file
--

for line in io . lines () do
    local numbers = {}
    for n in line : gmatch ("([1-9][0-9]*)") do
        if numbers [n] == nil then
            numbers [n] = 1
        else
            numbers [n] = numbers [n] + 1
        end
    end
    for number, count in pairs (numbers) do
        if numbers [number] % 2 == 1 then
            print (number)
        end
    end
end
