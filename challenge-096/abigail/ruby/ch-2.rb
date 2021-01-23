#!/usr/bin/ruby

#
# See ../README.md
#

#
# Run as: ruby ch-2.rb < input-file
#

def LevenshteinDistance (first, second)
    n = first  . length
    m = second . length
    distance = []
    for i in 0 .. n do
        distance [i] = []
        for j in 0 .. m do
            distance [i] [j] = i == 0 || j == 0 ? i + j
                    : [distance [i - 1] [j]     + 1,
                       distance [i]     [j - 1] + 1,
                       distance [i - 1] [j - 1] +
                          (first [i - 1] == second [j - 1] ? 0 : 1)] . min
        end
        #
        # Release memory
        #
        if i > 1
            distance [i - 1] = nil
        end
    end
    return distance [n] [m]
end

ARGF . each_line do |_|
    words = (_ . split (/\s+/)) . grep (/\S/)
    puts (LevenshteinDistance words [0], words [1])
end
