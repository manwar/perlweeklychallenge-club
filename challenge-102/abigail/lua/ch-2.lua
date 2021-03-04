#!/opt/local/bin/lua

--
-- See ../README.md
--

--
-- Run as: lua ch-2.lua < input-file
--

--
-- Working from the end of the required string backwards, we alternate
-- placing a hash, and placing a number. We place them in an array out,
-- and at the end, print out said array in reverse order.
--
for index in io . lines () do
    index = tonumber (index)
    out = {}
    hash = false
    i = 0
    while index > 0 do
        hash = not hash
        i = i + 1
        if  hash then
            out [i] = "#"
            index = index - 1
        else 
            out [i] = index + 1
            index = index - tostring (index + 1) : len ()
        end
    end
    for j = i, 1, -1 do
        io . write (out [j])
    end
    io . write ("\n")
end
