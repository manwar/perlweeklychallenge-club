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
    puts ( (num & ~0xFF)      \
         | (num &  0x0F) << 4 \
         | (num &  0xF0) >> 4)
end
