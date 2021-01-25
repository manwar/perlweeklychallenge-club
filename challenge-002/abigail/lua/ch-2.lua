#!/opt/local/bin/lua

--
-- See ../README.md
--

--
-- Run as: lua ch-2.lua {-f | -t} < input-file
--
--    -f: Translate from base 35 to base 10
--    -t: Translate to base 35 from base 10
--

local do_to_base   =  0
local do_from_base =  0
local BASE      = 35

--
-- Parse option, and exit if incorrect
--
if   #arg == 1
then if   arg [1] == "-f"
     then do_from_base = 1
     end
     if   arg [1] == "-t"
     then do_to_base   = 1
     end
end
if   do_to_base + do_from_base ~= 1
then io . stderr : write ("Need exactly one of '-f' or '-t'\n")
     os . exit (1)
end

--
-- Create an array, mapping base 10 numbers to base 35 digits, and vice versa
--
local digits = {}
for i = 0, 9 do
    digits [i] = i
    digits [i .. ""] = i
end
for i = 10, BASE - 1 do
    local char = string . char (65 + i - 10);
    digits [char] = i;
    digits [i] = char;
    digits [i .. ""] = char;
end

--
-- Take a (base 10) number, turn it to a base 35 number
--
function to_base (number)
    local out = ''
    while number > 0 do
        local n = number % BASE
        out = digits [n] .. out
        number = math . floor (number / BASE)
    end
    return out
end

--
-- Take a base 35 number (as a string), turn it to a base 10 number
--
function from_base (number)
    local out = 0
    for char in number : gmatch "." do
        out = out * BASE + tonumber (digits [char])
    end
    return out
end

--
-- Iterate over the input, call to_base/from_base depending 
-- on the command line option.
--
for line in io . lines () do
    if do_to_base == 1
    then io . write (to_base (tonumber (line)), "\n")
    else io . write (from_base (line), "\n")
    end
end
