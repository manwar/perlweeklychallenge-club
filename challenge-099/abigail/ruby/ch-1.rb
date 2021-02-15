#!/usr/bin/ruby

#
# See ../README.md
#
 
#
# Run as: ruby ch-1.rb < input-file
#

#
# Read a string and a pattern. Turn the pattern into a regular expression:
#    - '?'  becames '.'
#    - '*'  becomes '.*'
#    - any other character will be quotemetaed.
# 
# Then map the string against the pattern, anchored.
#

ARGF . each_line do |_|
    (string, pattern) = _ . strip . split
    pattern . gsub! (/./) {|_| 
         _ == "?"          ? "."
      :  _ == "*"          ? ".*"
      : (_ . match (/\W/)) ? "\\" + _
      :  _}
    pattern = "^" + pattern + "$"
    puts (string . match (pattern)) ? 1 : 0
end
