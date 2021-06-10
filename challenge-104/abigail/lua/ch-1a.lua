#!/opt/local/bin/lua

--
-- See ../README.md
--

--
-- Run as: lua ch-1a.lua
--

--
-- Initialize the cache
--

local cache = {}
cache [0] =  0
cache [1] =  1
local max = 50

--
-- Fusc sequence is defined as:
--            ( n,                                        0 <= n <= 1
-- fusc (n) = { fusc  (n / 2),                            n > 1 && n even
--            ( fusc ((n - 1) / 2) + fusc ((n + 1) / 2),  n > 1 && n odd
--

function fusc (n)
    if cache [n] == nil then
        if n % 2 == 1 then
            cache [n] = fusc ((n - 1) / 2) + fusc ((n + 1) / 2)
        else
            cache [n] = fusc (n / 2)
        end
    end
    return cache [n]
end


--
-- Calculate the values and print them
--

for i = 0, max - 1 do
    if i > 0
    then io . write (" ")
    end
    io . write (fusc (i))
end
io . write ("\n")
