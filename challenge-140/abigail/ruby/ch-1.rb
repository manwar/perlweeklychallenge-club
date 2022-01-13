#!/usr/bin/ruby

#
# See ../README.md
#
 
#
# Run as: ruby ch-1.rb < input-file
#

ARGF . each_line do
    | line |
    a, b = line . strip() . split (" ")
    puts (a . to_i(2) + b . to_i(2)) . to_s(2)
end
