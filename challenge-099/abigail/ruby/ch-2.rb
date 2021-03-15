#!/usr/bin/ruby

#
# See ../README.md
#
 
#
# Run as: ruby ch-2.rb < input-file
#

# 
# Recursively count matches:
#   - If either the string or the pattern is empty, there are no matches.
#   - Else, + count the matches if we don't match at the first character
#             if the string.
#           + if the first character of the string equals the first
#             character of the pattern:
#             o  add 1 if the pattern is just one character long
#             o  else, add the number of matches starting from the
#                then next character in the string, and the next
#                character in the pattern.
#
def matches (string, pattern)
    if string . length == 0 || pattern . length == 0
        return 0
    end

    count = matches string [1 .. -1], pattern

    if string [0] == pattern [0]
        if pattern . length == 1
            count += 1
        else
            count += matches string [1 .. -1], pattern [1 .. -1]
        end
    end

    return count
end

ARGF . each_line do |_|
    (string, pattern) = _ . strip . split
    puts matches string, pattern
end
