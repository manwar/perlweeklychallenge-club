#!/usr/bin/ruby

#
# See ../README.md
#
 
#
# Run as: ruby ch-2.rb < input-file
#

ARGF . each_line do
    |line|
    sum_of_squares = 0
    line . split('') . each do
        |char|
        if   "1" <= char && char <= "9"
        then sum_of_squares += (char . to_i) ** 2
        end
    end
    puts (sum_of_squares == (Math . sqrt (sum_of_squares) . round) ** 2 ? 1 : 0)
end
