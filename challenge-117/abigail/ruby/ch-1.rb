#!/usr/bin/ruby

#
# See ../README.md
#
 
#
# Run as: ruby ch-1.rb < input-file
#

sum = 0
SUM_15 = 120
ARGF . each_line do
    |line|
    sum += ((line . split (/,/)) [0]) . to_i
end

puts (SUM_15 - sum)
