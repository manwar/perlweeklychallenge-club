#!/opt/local/bin/lua

--
-- See ../README.md
--

--
-- Run as: lua ch-1.lua
--

local count         = 10
local nr_of_divisor =  8

local n = 0
while count > 0 do
    n = n + 1
    local s = math . floor (math . sqrt (n))
    if n == s * s then
        goto end_while
    end
    local c = 0
    for d = 1, s do
        if n % d == 0 then
            c = c + 2
            if c > nr_of_divisor then
                goto end_while
            end
        end
    end
    if c == nr_of_divisor then
        print (n)
        count = count - 1
    end

    ::end_while::
end
