#!/opt/local/bin/lua

--
-- See ../README.md
--

--
-- Run as: lua ch-2.lua < input-file
--

local w = {1, 3, 1, 7, 3, 9, 1}

for line in io . lines () do
    if line : find ("^[0-9BCDFGHJKLMNPQRSTVWXYZ]*$") then
        local check = 0
        for i = 1, 7 do
            local byte = string . byte (line : sub (i, i))
            if   byte <= string . byte ("9")
            then byte  = byte - string . byte ("0")
            else byte  = byte - string . byte ("A") + 10
            end
            check = check + w [i] * byte
         end
         if check % 10 == 0
         then print (1)
         else print (0)
         end
    else
        print (0)
    end
end
