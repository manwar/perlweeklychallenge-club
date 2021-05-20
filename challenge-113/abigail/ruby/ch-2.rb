#!/usr/bin/ruby

#
# See ../README.md
#
 
#
# Run as: ruby ch-2.rb < input-file
#

ARGF . each_line do
    | line |
    numbers = line . split . map do
        | _ |
        _ . to_i
    end
    sum = 0
    numbers . map do
        | n |
        sum += n
    end
        
    puts (numbers . map do
        | n |
        sum - n
    end . join (" "))
end
