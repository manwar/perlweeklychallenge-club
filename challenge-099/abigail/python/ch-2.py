#!/opt/local/bin/python

#
# See ../README.md
#

#
# Run as python ch-1.py < input-file
#

import fileinput
import re

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
def matches (string, pattern):
    if len (string) == 0 or len (pattern) == 0:
        return 0

    count = matches (string [1:], pattern)

    if string [0] == pattern [0]:
        if len (pattern) == 1:
            count = count + 1
        else:
            count = count + matches (string [1:], pattern [1:])

    return count

for line in fileinput . input ():
    (string, pattern) = re . split (r' +', line . strip ())
    print (matches (string, pattern))
