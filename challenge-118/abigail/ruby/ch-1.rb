#!/usr/bin/ruby

#
# See ../README.md
#
 
#
# Run as: ruby ch-1.rb < input-file
#

ARGF . each_line do
    |dec|
    bin = "%b" % dec
    puts (bin == bin . reverse ? 1 : 0)
end
