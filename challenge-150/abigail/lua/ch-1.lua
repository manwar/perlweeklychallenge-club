#!/opt/local/bin/lua

--
-- See https://theweeklychallenge.org/blog/perl-weekly-challenge-150
--

--
-- Run as: lua ch-1.lua < input-file
--

local LENGTH = 51

for line in io . lines () do
    local fib_prev, fib_last = line : match ("(%S+) (%S+)")
    while fib_last : len () < LENGTH do
        fib_prev, fib_last = fib_last, fib_prev .. fib_last
    end
    print (fib_last : sub (LENGTH, LENGTH))
end
