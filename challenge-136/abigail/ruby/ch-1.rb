#!/usr/bin/ruby

#
# See ../README.md
#
 
#
# Run as: ruby ch-1.rb < input-file
#

ARGF . each_line do
    | line |
    m, n = line . split . map {|x| x . to_i}
    gcd = m . gcd (n)
    valid = 0
    if gcd > 1 then
        while gcd % 2 == 0 do
            gcd /= 2
        end
        if gcd == 1 then
            valid = 1
        end
    end
    puts (valid)
end
