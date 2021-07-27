#!/usr/bin/ruby

#
# See ../README.md
#
 
#
# Run as: ruby ch-1.rb < input-file
#

s = 0
c = 0

ARGF . each_line do
    |n|
    s += n . to_i
    c += 1
    puts (s / c)
end
