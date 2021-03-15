#!/opt/local/bin/lua

--
-- See ../README.md
--

--
-- Run as: lua ch-1.lua -s SHIFT < input-file
--

local shift         = -1
local NR_OF_LETTERS = 26
local ORD_A         = string . byte ("A")

--
-- Parse option, and exit if incorrect
--
if   #arg == 2 and arg [1] == "-s"
then shift = arg [2] % NR_OF_LETTERS
end

if shift < 0
then io . stderr : write ("Requires a '-s SHIFT' option\n")
     os . exit (1)
end


--
-- Shift a capital letter 'shift' places to the left,
-- rotating if shifted before 'A'
--
function do_shift (char, shift)
    local n = string . byte (char) - shift
    if   n < ORD_A
    then n = n + NR_OF_LETTERS
    end
    return string . char (n)
end

--
-- Shift capital letters
--
for line in io . lines () do
    io . write (string . gsub (line, "[A-Z]", function (ch)
             return do_shift (ch, shift)
         end), "\n")
end
