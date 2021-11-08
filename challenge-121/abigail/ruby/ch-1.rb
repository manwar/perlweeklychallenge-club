#!/usr/bin/ruby

#
# See ../README.md
#
 
#
# Run as: ruby ch-1.rb < input-file
#

ARGF . each_line do
    |line|
    (m, n) = line . split(" ") . map {|_| _ . to_i}
    puts (m ^ (1 << (n - 1)))
end
