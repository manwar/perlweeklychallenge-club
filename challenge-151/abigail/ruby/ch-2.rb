#!/usr/bin/ruby

#
# See https://theweeklychallenge.org/blog/perl-weekly-challenge-151
#
 
#
# Run as: ruby ch-2.rb < input-file
#

ARGF . each_line do |line|
    (h = line . split . map do |n| n . to_i end) . push(0, 0)
    (h . length - 3) . downto(2) do |i|
        h[i] = [h[i] + h[i + 2], h[i + 1]] . max
    end
    puts (h[0] + h[2])
end
