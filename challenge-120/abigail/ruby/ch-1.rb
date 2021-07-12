#!/usr/bin/ruby

#
# See ../README.md
#
 
#
# Run as: ruby ch-1.rb < input-file
#

ARGF . each_line do
    |line|
    num = line . to_i
    puts ( (num & 0x55) << 1 \
         | (num & 0xAA) >> 1)
end
