#!/usr/bin/ruby

#
# See ../README.md
#
 
#
# Run as: ruby ch-1.rb
#

count          = 10
nr_of_divisors =  8

n = 0
while count > 0 do
    n = n + 1
    s = Math . sqrt(n) . floor()
    if n == s * s then
       next
    end
    c = 0
    for d in 1 .. s do
        if n % d == 0 then
            c = c + 2
            if c > nr_of_divisors then
                break
            end
        end
    end
    if c == nr_of_divisors then
        puts (n)
        count = count - 1
    end
end
