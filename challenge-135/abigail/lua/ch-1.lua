#!/opt/local/bin/lua

--
-- See ../README.md
--

--
-- Run as: lua ch-1.lua < input-file
--

for line in io . lines () do
    line = line : gsub ("^[-+]%s*", "")
    if line : find ("%D") then
        print ("not an integer")
    else
        if line : len () % 2 == 0 then
            print ("even number of digits")
        else
            if line : len () < 3 then
                print ("too short")
            else
                local start = 1 + (line : len () - 3) / 2
                print (line : sub (start , start + 2))
            end
        end
    end
end
