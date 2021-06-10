#!/usr/bin/ruby

#
# See ../README.md
#
 
#
# Run as: ruby ch-1.rb < input-file
#
# Input will consist of lines; each line will have two numbers, N and k, N > 0,
# k > 0. For each line of input, we output a line with the Nth root of k.
#
# We're not doing any input validations; we're assuming it's correct.
#

#
# To find the Nth root of a number k, we just raise k to the power 1/N
#

ARGF . each_line do |_|
    n, k = _ . split (' ')
    puts (k . to_f ** (1 / n . to_f))
end
