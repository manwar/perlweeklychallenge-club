#!/opt/local/bin/lua

--
-- See ../README.md
--

--
-- Run as: lua ch-1.lua < input-file
--

--
-- Find the binary representation of a number. 
-- Note that the function return a string in reverse order;
-- this will do for our purpose as we want a palindrome anyway.
--
function dec2bin (dec)
    local bin = {}
    while dec > 0 do 
        bin [#bin + 1] = dec % 2
        dec = math . floor (dec / 2)
    end
    return table . concat (bin)
end

for line in io . lines () do
    bin = dec2bin (tonumber (line))
    if bin == string . reverse (bin) then
        print (1)
    else
        print (0)
    end
end
