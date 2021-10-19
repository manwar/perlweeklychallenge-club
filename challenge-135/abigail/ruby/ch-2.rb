#!/usr/bin/ruby

#
# See ../README.md
#
 
#
# Run as: ruby ch-2.rb < input-file
#

w = [1, 3, 1, 7, 3, 9, 1]

ARGF . each_line do
    | line |
    line . strip!
    if line . match (/^[0-9BCDFGHJKLMNPQRSTVWXYZ]{6}[0-9]$/) then
        check = 0
        line . split('') . each_with_index do
            | char, i |
            val = char . ord
            if val <= "9" . ord then
                val -= "0" . ord
            else
                val -= "A" . ord
                val += 10
            end
            check += w [i] * val
        end
        if check % 10 == 0 then
            puts (1)
        else
            puts (0)
        end
    else
        puts (0)
    end
end
