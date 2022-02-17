#!/usr/bin/ruby

#
# See https://theweeklychallenge.org/blog/perl-weekly-challenge-152
#
 
#
# Run as: ruby ch-1.rb < input-file
#

ARGF . each_line do |line|
    minsum = 0
    n      = 1
    m      = n
    min    = 0
    line . split . map do |num| 
        num = num . to_i
        if n == m or num < min then
            min = num
        end
        m -= 1
        if m == 0 then
            minsum += min
            n      += 1
            m       = n
            min     = 0
        end
    end
    puts (minsum)
end
