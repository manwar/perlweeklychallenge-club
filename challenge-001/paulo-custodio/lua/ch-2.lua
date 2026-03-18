#!/usr/bin/env lua

--[[
Perl Weekly Challenge 001 - Task 2 - solution by Paulo Custodio
https://theweeklychallenge.org/blog/perl-weekly-challenge-001/
--]]

for i=1,arg[1] do
    if     i%15==0 then io.write("fizzbuzz\n")
    elseif i% 3==0 then io.write("fizz\n")
    elseif i% 5==0 then io.write("buzz\n")
    else                io.write(i, "\n")
    end
end
