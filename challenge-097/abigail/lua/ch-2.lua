#!/opt/local/bin/lua

--
-- See ../README.md
--

--
-- Run as: lua ch-2.lua -s SIZE < input-file
--

--
-- Parse option, and exit if incorrect
--

local size = -1
if   #arg == 2 and arg [1] == "-s"
then size = arg [2] + 0
end

if size < 0
then io . stderr : write ("Requires a '-s SIZE' option\n")
     os . exit (1)
end


--
-- Iterate over the input, line by line.
-- For each line, count the number of 0's on each position of the sections
-- Calculate the number of 1's. Add the minimum of the two to a running sum.
--
for line in io . lines () do
    local sections = #line / size
    local sum   = 0
    for i = 0, size - 1 do
        local zeros = 0
        for j = 0, sections - 1 do
            index = j * size + i + 1
            if   string . sub (line, index, index) == "0"
            then zeros = zeros + 1
            end
        end
        local ones = sections - zeros
        if   zeros < ones
        then sum = sum + zeros
        else sum = sum + ones
        end
    end
    io . write (sum, "\n")
end
