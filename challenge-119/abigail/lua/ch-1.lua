#!/opt/local/bin/lua

--
-- See ../README.md
--

--
-- Run as: lua ch-1.lua < input-file
--

for line in io . lines () do
    num = tonumber (line)
    print (                (num - (num   % 0x100))
           +              ((num % 0x010) * 0x010)
           + math . floor ((num % 0x100) / 0x010))
end
