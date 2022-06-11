#!/usr/bin/ruby

#
# See https://theweeklychallenge.org/blog/perl-weekly-challenge-147
#
 
#
# Run as: ruby ch-2.rb
#

pentagon = {}
p = 0
n = 0
done = false


while not done do
    p = p + n + n + n + 1
    n = n + 1
    pentagon [p] = true
    pentagon . each do
        | seen, _ |
        if (seen + seen <= p && pentagon . key?(p - seen) \
                             && pentagon . key?(p - seen - seen)) then
            puts (seen . to_s + " " + (p - seen) . to_s)
            done = true
            break
        end
    end
end
