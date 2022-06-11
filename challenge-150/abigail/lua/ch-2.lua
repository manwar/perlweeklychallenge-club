#!/opt/local/bin/lua

--
-- See https://theweeklychallenge.org/blog/perl-weekly-challenge-150
--

--
-- Run as: lua ch-2.lua
--

local primes = {2, 3, 5, 7, 11, 13, 17, 19}
local max    = 500

for n = 1, max do
    local has_square = 0
    local p
    for _, p in ipairs (primes) do
        if n % (p * p) == 0 then
            has_square = 1
        end
    end
    if has_square == 0 then
        io . write (n)
        io . write (" ")
    end
end
io . write ("\n")
