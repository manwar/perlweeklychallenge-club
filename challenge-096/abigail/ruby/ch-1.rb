#!/usr/bin/ruby

#
# See ../README.md
#

#
# Run as: ruby ch-1.rb < input-file
#

ARGF . each_line do |_|
    puts ((_ . split (/\s+/)) . grep (/\S/)) . reverse . join (" ")
end
