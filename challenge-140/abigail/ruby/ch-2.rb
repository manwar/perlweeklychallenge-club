#!/usr/bin/ruby

#
# See ../README.md
#
 
#
# Run as: ruby ch-2.rb < input-file
#

ARGF . each_line do
    | line |
    i, j, k = line . strip() . split . map {|x| x . to_i}
    n = 0
    while k > 0 do
        n = n + 1
        s = Math . sqrt(n) . floor()
        for d in 1 .. s do
            if n % d == 0 then
                if d <= i && n / d <= j then k = k - 1 end
                if d <= j && n / d <= i then k = k - 1 end
                if n == d * d           then k = k + 1 end
            end
        end
    end
    puts (n)
end
