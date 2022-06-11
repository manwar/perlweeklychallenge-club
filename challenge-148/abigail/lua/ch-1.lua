#!/opt/local/bin/lua

--
-- See https://theweeklychallenge.org/blog/perl-weekly-challenge-148
--

--
-- Run as: lua ch-1.lua
--

for i = 0, 100 do
    local t = math . floor (i / 10)
    local u = i % 10
    if not (i == 0 or t == 1 or u == 1 or t == 7 or u == 7 
                   or t == 8 or u == 8 or t == 9 or u == 9
                   or t == 2 or u == 3 or u == 5 or i == 100) then
        io . write (i, " ")
    end
end

io . write ("\n")
