#!/usr/bin/ruby

#
# See ../README.md
#
 
#
# Run as: ruby ch-1.rb < input-file
#

ARGF . each_line do |_|
     if _ .  gsub(/\s+/,           "")     # Remove white space
          .   sub(/^\+/,           "00")   # Replace leading + with 00
          .   sub(/^\([0-9]{2}\)/, "0000") # Replace leading (NN) with 0000
          . match /^[0-9]{14}$/            # Exactly 14 digits should be left
     then print (_)
     end
end
