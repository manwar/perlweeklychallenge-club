#!/usr/bin/ruby

#
# See ../README.md
#
 
#
# Run as: ruby ch-2.rb < input-file
#

#
# See ../README.md for details about this method
#
def long_division (numerator, denominator)
    base       = 10
    fraction   = (numerator / denominator) . to_s + "."
    position   = fraction . length
    seen       = {}

    numerator %= denominator

    while !seen [numerator] do
        if   numerator == 0
        then return (fraction)
        end
        seen [numerator] = position
        fraction += (base * numerator / denominator) . to_s
        numerator =  base * numerator % denominator
        position += 1
    end

    return (fraction [0 .. seen [numerator]   - 1] + "(" +
            fraction [     seen [numerator] .. -1] + ")")
          
end



ARGF . each_line do |_|
    numerator, denominator = _ . split (/\s+/)
    puts (long_division numerator . to_i, denominator . to_i)
end
