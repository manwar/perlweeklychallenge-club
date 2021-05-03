#!/usr/bin/ruby

#
# See ../README.md
#
 
#
# Run as: ruby ch-2.rb < input-file
#

output = []

#
# Read the input, split on comma, build output strings.
#
ARGF . each_line do
   |_|
    _ . strip . split(/,/) . each_with_index do
       |_, i|
        output [i] = (output [i] || "") + _ + ","
    end
end

#
# Print the output strings, without the trailing commas.
#
output . each do
   |_|
    puts _ [0 .. -2]
end
