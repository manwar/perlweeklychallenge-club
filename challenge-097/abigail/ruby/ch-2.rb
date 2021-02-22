#!/usr/bin/ruby

#
# See ../README.md
#
 
#
# Run as: ruby ch-2.rb -s SIZE < input-file
#

require 'optparse'

#
# Parse and validate options
#
params = ARGV . getopts ('s:')
size   = params ["s"] ? params ["s"] . to_i : -1

if size < 0
    STDERR . puts "Requires a -s SIZE option"
    exit 1
end


#
# Iterate over the input. For each position, count the number of 0s,
# and calculate the number of 1s. Sum the minimum of those numbers.
#
ARGF . each_line do |line|
     sections = (line . length - 1) / size
     sum = 0
     for i in 0 .. size - 1 do
         zeros = 0
         for j in 0 .. sections - 1 do
             index = j * size + i
             if   line [index, 1] == "0"
             then zeros += 1
             end
         end
         ones = sections - zeros
         sum += [zeros, ones] . min
     end
     puts sum
end
