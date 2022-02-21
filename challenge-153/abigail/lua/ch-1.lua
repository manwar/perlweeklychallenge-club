#!/opt/local/bin/lua

--
-- See https://theweeklychallenge.org/blog/perl-weekly-challenge-153
--

--
-- Run as: lua ch-1.lua
--

local sum = 1
local fac = 1

io . write (sum)

for n = 1, 9 do
    fac = fac * n
    sum = sum + fac
    io . write (" ", sum)
end

io . write ("\n")
