#!/usr/bin/ruby

#
# See ../README.md
#
 
#
# Run as: ruby ch-1.rb < input-file
#

ARGF . each_line do
    | line |
    out = 1
    seen = {}
    line . scan(/[-+]?[0-9]+/) do
        | number |
        if seen [number] then
            out = 0
        else
            seen [number] = 1
        end
    end
    puts (out)
end
