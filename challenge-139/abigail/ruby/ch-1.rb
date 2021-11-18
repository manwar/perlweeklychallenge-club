#!/usr/bin/ruby

#
# See ../README.md
#
 
#
# Run as: ruby ch-1.rb < input-file
#

ARGF . each_line do
    | line |
    sorted = 1
    list = line . strip() . split(" ")
    list . map . with_index do
        | _, i |
        if i > 0 && list [i - 1] > list [i] then
            sorted = 0
        end
    end
    puts (sorted)
end
