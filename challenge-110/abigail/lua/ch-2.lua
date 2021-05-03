#!/opt/local/bin/lua

--
-- See ../README.md
--

--
-- Run as: lua ch-2.lua < input-file
--

--
-- Read in the input, split each line on commas, and create
-- the ouput strings from the split field.
--
local output = {}
for line in io . lines () do
    local i = 1
    for field in line : gmatch ("[^,\n]+")
    do if   output [i] == nil
       then output [i] = ""
       end
       output [i] = output [i] .. field .. ","
       i = i + 1
    end
end

--
-- Print the output
--
for _, line in ipairs (output)
do  print (line : sub (1, -2))
end
