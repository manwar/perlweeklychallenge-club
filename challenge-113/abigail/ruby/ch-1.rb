#!/usr/bin/ruby

#
# See ../README.md
#
 
#
# Run as: ruby ch-1.rb < input-file
#

#     
# For a description of the algorithm, and the proof why this is correct:
# https://abigail.github.io/HTML/Perl-Weekly-Challenge/week-113-1.html
#  

gcds = [0, 1, 2, 1, 2, 5, 2, 1, 2, 1]

ARGF . each_line do
    | line |
    n, d = line . split
    n = n . to_i
    d = d . to_i
    if   d == 0
         puts (n >= 100 || n % 10 == 0 ? 1 : 0)
         next
    end

    if   n >= d * 10
    then puts (1)
         next
    end

    done = false
    for i in 0 .. d / gcds [d] - 1 do
        t = n - 10 * i - d
        if   t >= 0 && t % d == 0
        then puts (1)
             done = true
             break
        end
    end
    if not done
    then puts (0)
    end
end
