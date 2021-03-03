#!/usr/bin/ruby

#
# See ../README.md
#
 
#
# Run as: ruby ch-2.rb < input-file
#

#
# Working from the end of the required string backwards, we alternate
# placing a hash, and placing a number. We place them in an array @out,
# and at the end, print out said array in reverse order.
#

ARGF . each_line do |_|
    index = _ . to_i
    out = Array . new
    hash = false
    while index > 0 do
        if hash = !hash
            out . push ("#")
            index -= 1
        else
            out . push ((index + 1) . to_s)
            index -=    (index + 1) . to_s . length
        end
    end
    puts (out . reverse . join)
end
