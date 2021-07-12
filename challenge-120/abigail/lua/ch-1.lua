#!/opt/local/bin/lua

--
-- See ../README.md
--

--
-- Run as: lua ch-1.lua < input-file
--

for line in io . lines () do
    num = tonumber (line)
    out = 0
    for i = 0, 7 do
        bit = math . floor ((num - (num % (2 ^ i))) / (2 ^ i)) % 2
        if bit == 1
        then
            if i % 2 == 1
            then
                out = out + 2 ^ (i - 1)
            else
                out = out + 2 ^ (i + 1)
            end
        end
    end
    print (out)
end
