#!/opt/local/bin/lua

--
-- See ../README.md
--

--
-- Run as: lua ch-1.lua < input-file
--

local content = {};

function readN (filename, amount)
    if content [filename] == nil
    then --
         -- Read the content of the file, strip the trailing
         -- newline, and store the content in the table 'content'
         --
         content [filename] = assert (io . open (filename, "r")) :
                              read ("*all")                      :
                              gsub ("\n$", "")
    end
    local out = content [filename] : sub (1, amount)
    content [filename] = content [filename] : sub (amount + 1)
    return out
end

for line in io . lines () do
    --
    -- Split the line on whitespace, call readN() with the
    -- result, and print the return value of readN().
    --
    print (readN (line : match ("(%S+) (%S+)")))
end
