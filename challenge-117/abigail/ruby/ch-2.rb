#!/usr/bin/ruby

#
# See ../README.md
#
 
#
# Run as: ruby ch-2.rb < input-file
#

def steps (x, y, path)
    if   x == 0 && y == 0
    then puts (path)
         return
    end
    if   x > 0
    then steps(x - 1, y,     path + "R")
         steps(x - 1, y + 1, path + "L")
    end
    if   y > 0
    then steps(x,     y - 1, path + "H")
    end
end

steps($stdin . read . to_i, 0, "")
