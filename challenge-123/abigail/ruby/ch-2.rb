#!/usr/bin/ruby

#
# See ../README.md
#
 
#
# Run as: ruby ch-2.rb < input-file
#

ARGF . each_line do
    |line|
    x1, y1, x2, y2, x3, y3, x4, y4 = line . split(" ") . map {|n| n . to_i}
    e1 = (x1 - x2) ** 2 + (y1 - y2) ** 2
    e2 = (x2 - x3) ** 2 + (y2 - y3) ** 2
    e3 = (x3 - x4) ** 2 + (y3 - y4) ** 2
    e4 = (x4 - x1) ** 2 + (y4 - y1) ** 2
    d1 = (x1 - x3) ** 2 + (y1 - y3) ** 2
    d2 = (x2 - x4) ** 2 + (y2 - y4) ** 2
    puts (e1 == e2 && e2 == e3 && e3 == e4 && d1 == d2 ? 1 : 0)
end
