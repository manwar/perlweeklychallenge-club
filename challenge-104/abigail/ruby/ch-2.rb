#!/usr/bin/ruby

#
# See ../README.md
#
 
#
# Run as: ruby ch-2.rb
#

tokens   = 12
max_take =  3


while tokens > 0 do
    printf "How many tokens do you take? (%2d token%s are left) ",
                    tokens, tokens == 1 ? "" : "s"
    take = STDIN . gets . to_i
    if 1 <= take && take <= max_take
    then takes = max_take + 1 - take
         printf "Computer takes %d token%s\n", takes, takes == 1 ? "" : "s"
         tokens -= 4
    end
end

puts "Computer wins"
