#!/usr/bin/ruby

#
# See https://theweeklychallenge.org/blog/perl-weekly-challenge-153
#
 
#
# Run as: ruby ch-1.rb
#

print sum = fac = 1
for n in 1 .. 9 do
    print " ", sum += fac *= n
end
print "\n"
