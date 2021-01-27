#!/usr/bin/ruby

#
# See ../README.md
#
 
#
# Run as: ruby ch-2.rb -s SECTIONS < input-file
#

require 'optparse'

NR_OF_LETTERS = 26


#
# Parse and validate options
#
params   = ARGV . getopts ('s:')
sections = params ["s"] ? params ["s"] . to_i : -1

if sections < 0
    STDERR . puts "Requires a -s SECTIONS option"
    exit 1
end


#
# Iterate over the input. For each position, count the number of 0s,
# and calculate the number of 1s. Sum the minimum of those numbers.
#
ARGF . each_line do |line|
     s_len = (line . length - 1) / sections
     sum = 0
     for i in 0 .. s_len - 1 do
         zeros = 0
         for j in 0 .. sections - 1 do
             index = j * s_len + i
             if   line [index, 1] == "0"
             then zeros += 1
             end
         end
         ones = sections - zeros
         sum += [zeros, ones] . min
     end
     puts sum
end
