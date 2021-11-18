#!/opt/local/bin/lua

--
-- See ../README.md
--

--
-- Run as: lua ch-2.lua
--

local BASE  = 10
local COUNT =  5

function is_long (number)
    local rest = 0
    local seen = {}

    for _ = 2, number do
        rest = (rest * BASE + BASE - 1) % number
        if (seen [rest] ~= nil) then
            return (0)
        end
        seen [rest] = 1
    end

    return (1)
end


local number = 1
while COUNT > 0 do
    number = number + 1
    if BASE % number == 0 then
        goto end_loop
    end
    if is_long (number) == 1 then
        print (number)
        COUNT = COUNT - 1
    end
    ::end_loop::
end
