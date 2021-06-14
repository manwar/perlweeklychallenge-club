#!/opt/local/bin/lua

--
-- See ../README.md
--

--
-- Run as: lua ch-1.lua < input-file
--

function make_sequence (string, start)
    if   string == start
    then return start
    end
    if   string : find ("^" .. start)
    then tail   = string : sub (#start + 1, -1)
         result = make_sequence (tail, tostring (tonumber (start) + 1))
         if   result ~= nil
         then return start .. "," .. result
         end
         result = make_sequence (tail, tostring (tonumber (start) - 1))
         if   result ~= nil
         then return start .. "," .. result
         end
    end
    return nil
end

for line in io . lines () do
    for i = 1, #line do
        start  = line : sub (1, i)
        result = make_sequence (line, start)
        if   result ~= nil
        then print (result)
             goto end_main
        end
    end
    ::end_main::
end
