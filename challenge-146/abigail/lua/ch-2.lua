#!/opt/local/bin/lua

--
-- See ../README.md
--

--
-- Run as: lua ch-2.lua < input-file
--

for line in io . lines () do
    local _, _, a, b = line : find ("([0-9]+)/([0-9]+)")
    a = tonumber (a)
    b = tonumber (b)
    for i = 1, 2 do
        if a < b then
            b = b - a
        else
            a = a - b
        end
        if a == 0 or b == 0 then
            goto out_of_loop
        end
        io . write (a .. "/" .. b .. " ")
    end
    ::out_of_loop::
    io . write ("\n")
end
