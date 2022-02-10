#!/usr/bin/ruby

#
# See https://theweeklychallenge.org/blog/perl-weekly-challenge-150
#
 
#
# Run as: ruby ch-2.rb
#

primes = [2, 3, 5, 7, 11, 13, 17, 19]
for n in 1 .. 500 do
    has_square = false
    for p in 0 .. 7 do
        if n % (primes[p] * primes[p]) == 0 then
            has_square = true
        end
    end
    if !has_square then
        print (n)
        print (" ")
    end
end
print ("\n")
