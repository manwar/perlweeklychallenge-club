#!/usr/bin/ruby

#
# See https://theweeklychallenge.org/blog/perl-weekly-challenge-153
#
 
#
# Run as: ruby ch-2.rb < input-file
#

fac = []
fac [0] = 1
for n in 1 .. 9 do
    fac [n] = n * fac [n - 1]
end

ARGF . each_line do |num|
    num = num . to_i
    sum = 0
    n   = num
    while n > 0 do
        sum += fac[n % 10]
        n   /= 10
    end
    if sum == num then
        puts (1)
    else
        puts (0)
    end
end
