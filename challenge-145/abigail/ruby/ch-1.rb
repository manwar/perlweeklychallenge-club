#!/usr/bin/ruby

#
# See ../README.md
#
 
#
# Run as: ruby ch-1.rb < input-file
#

a = ARGF . readline() . split(" ") . map {|n| n . to_i}
b = ARGF . readline() . split(" ") . map {|n| n . to_i}

sum = 0
for i in 0 .. a . length() - 1 do
    sum += a [i] * b [i]
end

puts (sum)
