#!/usr/bin/ruby

#
# See ../README.md
#
 
#
# Run as: ruby ch-2.rb < input-file
#

ARGF . each_line do
    |line|
    n, m = line . split
    seen = {}
    for i in 1 .. n . to_i do
        for j in 1 .. m . to_i do
            seen [i * j] = 1
        end
    end
    puts (seen . size)
end
