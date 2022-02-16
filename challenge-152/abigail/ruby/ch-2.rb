#!/usr/bin/ruby

#
# See https://theweeklychallenge.org/blog/perl-weekly-challenge-152
#
 
#
# Run as: ruby ch-2.rb < input-file
#

ARGF . each_line do |line|
    a_x1, a_y1, a_x2, a_y2, b_x1, b_y1, b_x2, b_y2 = 
          line . split . map do |n| n . to_i end

    puts (([a_x1, a_x2] . max - [a_x1, a_x2] . min)                 *
          ([a_y1, a_y2] . max - [a_y1, a_y2] . min)                 +
          ([b_x1, b_x2] . max - [b_x1, b_x2] . min)                 *
          ([b_y1, b_y2] . max - [b_y1, b_y2] . min)                 -
         [[[a_x1, a_x2] . max,  [b_x1, b_x2] . max] . min           -
          [[a_x1, a_x2] . min,  [b_x1, b_x2] . min] . max, 0] . max *
         [[[a_y1, a_y2] . max,  [b_y1, b_y2] . max] . min           -
          [[a_y1, a_y2] . min,  [b_y1, b_y2] . min] . max, 0] . max)
    
end
