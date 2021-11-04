#!/usr/bin/ruby

#
# See ../README.md
#
 
#
# Run as: ruby ch-1.rb < input-file
#

ARGF . each_line do
    |num|
    puts ((Math . exp(Math . log(num . to_i) / 2)) . to_i)
end
