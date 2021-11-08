#!/opt/local/bin/lua

--
-- See ../README.md
--

--
-- Run as: lua ch-2.lua < input-file
--

function next_number (prev_num)
    --
    -- Get the trailing 3s (tail), and the number before (num)
    -- and anything before it (prefix)
    --
    local _, _, prefix, num, tail =
        ("0" .. prev_num) : find ("(.*)([012])(3*)$")

    --
    -- Combine the prefix, num (with 1 added) and the tail (with
    -- its 3s replaced by 1s), then in the result, replace each '11'
    -- with '12', and remove the leading 0 (if any).
    --
    return (prefix .. tostring (tonumber (num) + 1) 
                   .. tail : gsub ("3", "1")) : gsub ("11", "12")
                                              : gsub ("^0", "")
end


for num in io . lines () do
    local number = "0"
    for _ = 1, tonumber (num) do
        number = next_number (number)
    end
    print (number)
end
