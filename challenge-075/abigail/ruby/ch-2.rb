#!/usr/bin/ruby

#
# See ../README.md
#
 
#
# Run as: ruby ch-2.rb < input-file
#

ARGF . each_line do
    |line|
    heights = line . split . map do
        |h|
        h . to_i
    end

    max_height = heights . max

    max_area = 0
    for h in 1 .. max_height do
        max = 0
        cur = 0
        heights . map do
            |height|
            if height >= h
                cur += 1
            else
                if max < cur
                   max = cur
                end
                cur = 0
            end
        end
        if max < cur
           max = cur
        end

        area = max * h
        if max_area < area
           max_area = area
        end
    end
    puts (max_area)
end
