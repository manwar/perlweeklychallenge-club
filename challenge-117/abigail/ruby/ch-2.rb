#!/usr/bin/ruby

#
# See ../README.md
#
 
#
# Run as: ruby ch-2.rb < input-file
#

def steps (x, y, prefix)
    if   x == 0 && y == 0
    then puts (prefix)
         return
    end
    if   x > 0
    then steps(x - 1, y,     prefix + "R")
         steps(x - 1, y + 1, prefix + "L")
    end
    if   y > 0
    then steps(x,     y - 1, prefix + "H")
    end
end

steps($stdin . read . to_i, 0, "")
