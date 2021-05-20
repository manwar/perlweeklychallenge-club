#!/usr/bin/ruby

#
# See ../README.md
#
 
#
# Run as: ruby ch-1.rb < input-file
#

tens = [0, 0, 1, 2, 1, 0, 2, 6, 3, 8]

ARGF . each_line do
    | line |
    n, d = line . split
    n = n . to_i
    d = d . to_i
    d10 = d == 0 ? 100 : d * 10
    if   n >= d10 || n % (d == 0 ? 10 : d) == 0
    then puts (1)
         next
    end
    done = false
    for i in 1 .. tens [d] do
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
