#!/usr/bin/env lua

--[[
Challenge 001

# Challenge #2
# Write a one-liner to solve the FizzBuzz problem and print the numbers 1
# through 20. However, any number divisible by 3 should be replaced by the word
# ‘fizz’ and any divisible by 5 by the word ‘buzz’. Those numbers that are both
# divisible by 3 and 5 become ‘fizzbuzz’.
--]]

for i=1,arg[1] do
    if     i%15==0 then io.write("fizzbuzz\n")
    elseif i% 3==0 then io.write("fizz\n")
    elseif i% 5==0 then io.write("buzz\n")
    else                io.write(i, "\n")
    end
end
