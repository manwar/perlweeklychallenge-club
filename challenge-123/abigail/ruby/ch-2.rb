#!/usr/bin/ruby

#
# See ../README.md
#
 
#
# Run as: ruby ch-2.rb < input-file
#

def dist (x1, y1, x2, y2)
    return (x1 - x2) ** 2 + (y1 - y2) ** 2
end

ARGF . each_line do
    |line|
    x1, y1, x2, y2, x3, y3, x4, y4 = line . split(" ") . map {|n| n . to_i}

    puts (dist(x1, y1, x2, y2) == dist(x2, y2, x3, y3) &&
          dist(x2, y2, x3, y3) == dist(x3, y3, x4, y4) &&
          dist(x3, y3, x4, y4) == dist(x4, y4, x1, y1) &&
          dist(x1, y1, x3, y3) == dist(x2, y2, x4, y4) ? 1 : 0)
end
