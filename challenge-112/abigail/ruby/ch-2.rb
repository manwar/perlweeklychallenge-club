#!/usr/bin/ruby

#
# See ../README.md
#
 
#
# Run as: ruby ch-2.rb < input-file
#

SQRT5 = Math . sqrt 5
PHI   = (1 + SQRT5) / 2

ARGF . each_line do
    | n |
    puts ((PHI ** (n . to_i + 1) / SQRT5) . round)
end
