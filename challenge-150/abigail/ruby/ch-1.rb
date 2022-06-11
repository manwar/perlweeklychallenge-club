#!/usr/bin/ruby

#
# See https://theweeklychallenge.org/blog/perl-weekly-challenge-150
#
 
#
# Run as: ruby ch-1.rb < input-file
#

ARGF . each_line do |line|
    fib_prev, fib_last = line . strip() . split(" ")
    while fib_last . length < 51 do
        fib_prev, fib_last = fib_last, fib_prev + fib_last
    end
    puts (fib_last [50])
end
