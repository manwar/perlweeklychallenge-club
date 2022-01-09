#!/opt/local/bin/lua

--
-- See https://theweeklychallenge.org/blog/perl-weekly-challenge-002
--

--
-- Run as: lua ch-1.lua < input-file
--

for line in io . lines () do
    io . write (tonumber (line), "\n")
end
