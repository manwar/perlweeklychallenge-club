#!/opt/local/bin/lua

--
-- See ../README.md
--

--
-- Run as: lua ch-2.lua
--

local tokens   = 12
local max_take =  3

while tokens > 0
do  local s = ""
    if   not (tokens == 1)
    then s = "s"
    end
    io . write ("How many tokens do you take? ")
    io . write (string . format ("(%2d token%s are left) ", tokens, s))

    local take = tonumber (io . read ("*l"))

    if take and 1 <= take and take <= max_take
    then local takes = max_take + 1 - take
         local s = ""
         if   not (takes == 1)
         then s = "s"
         end
         io . write (string . format ("Computer takes %d token%s\n", takes, s))
         tokens = tokens - (max_take + 1)
    end
end

io . write ("Computer wins\n")
