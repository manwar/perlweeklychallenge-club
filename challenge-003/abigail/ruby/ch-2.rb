#!/usr/bin/ruby

#
# See ../README.md
#
 
#
# Run as: ruby ch-2.rb < input-file
#

ARGF . each_line do |_|
    rows = _ . to_i   

    #
    # 0-th row
    #
    row = [1]
    puts row [0]
    for r in 1 .. rows do
        #
        # Create new row
        #
        new = []
        for i in 0 .. r do
            new [i] = (i == 0 ? 0 : row [i - 1]) +
                      (i == r ? 0 : row [i])
            if i > 0
            then print " "
            end
            print new [i]
        end
        puts ""

        #
        # New row becomes current row
        #
        row = new
    end
end
