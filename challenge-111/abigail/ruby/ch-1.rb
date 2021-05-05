#!/usr/bin/ruby

#
# See ../README.md
#
 
#
# Run as: ruby ch-1.rb < input-file
#

matrix_size = 5

#
# Read in the matrix
#
matrix = {}
(1 .. matrix_size) . each do
    ARGF . readline . scan(/-?[0-9]+/) do
        |number|
        matrix [number] = 1
    end
end


#
# Read in the rest of the numbers, and print 1/0 whether or
# not they're present in the matrix.
#
ARGF . each_line do
    |number|
    puts (matrix [number . strip] ? 1 : 0)
end
