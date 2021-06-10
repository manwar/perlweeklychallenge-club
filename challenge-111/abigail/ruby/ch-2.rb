#!/usr/bin/ruby

#
# See ../README.md
#
 
#
# Run as: ruby ch-2.rb < input-file
#

#
# Create a pattern to match words with their characters in
# lexicographical order.
#
pat = "^"
("a" .. "z") . each do
    |letter|
    pat += letter + "*"
end
pat += "$"


#
# Find matching words, and remember the longest.
#
longest = ""
ARGF . each_line do
    |line|
    if line . downcase =~ /#{pat}/ && line . length > longest . length
        longest = line
    end
end

puts (longest)
