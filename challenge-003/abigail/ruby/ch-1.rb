#!/usr/bin/ruby

#
# See ../README.md
#
 
#
# Run as: ruby ch-1.rb < input-file
#

ARGF . each_line do |_|
     max = _ . to_i
     base2 = 1
     while base2 <= max
         base3 = base2
         while base3 <= max
             base5 = base3
             while base5 <= max
                 puts base5
                 base5 *= 5
             end
             base3 *= 3
         end
         base2 *= 2
     end
end
