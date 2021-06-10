#!/usr/bin/ruby

#
# See ../README.md
#
 
#
# Run as: ruby ch-1.rb < input-file
#

ARGF . each_line do |_|
    #
    # Split input on white space, turn the chucks into integers,
    # then sort the result.
    #
    n = (_ . split (/\s+/))
           . map {|_| _ . to_i}
           . sort

    #
    # Find the maximum difference.
    #
    max = 0
    n . each_index {|i|
            if i > 0 && (n [i] - n [i - 1]) > max
            then max = n [i] - n [i - 1]
            end
        }

    #
    # And print it
    #
    puts (max)
end
