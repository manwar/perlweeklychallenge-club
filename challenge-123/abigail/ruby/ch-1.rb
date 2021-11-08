#!/usr/bin/ruby

#
# See ../README.md
#
 
#
# Run as: ruby ch-1.rb < input-file
#

ugly   = [1]
next_2 =  0
next_3 =  0
next_5 =  0

ARGF . each_line do
    |n|
    n = n . to_i
    while ugly . length < n do
        ugly . push ([2 * ugly [next_2],
                      3 * ugly [next_3],
                      5 * ugly [next_5]] . min)

        next_2 += 1 if 2 * ugly [next_2] <= ugly [-1]
        next_3 += 1 if 3 * ugly [next_3] <= ugly [-1]
        next_5 += 1 if 5 * ugly [next_5] <= ugly [-1]
    end
    puts (ugly [n - 1])
end
