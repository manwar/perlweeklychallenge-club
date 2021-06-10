#!/opt/local/bin/python

#
# See ../README.md
#

#
# Run as: python ch-2.py < input-file
#

import fileinput
import string
import re


#
# Create a pattern which matches words with their characters in lexical order.
#
pat = "^"
for x in list (string . ascii_lowercase):
    pat = pat + x + "*"
pat += "$"
    

#
# Match strings with their characters in lexical order, and remember
# the longest of them.
#
longest = ""
for line in fileinput . input ():
    line = line . strip ()
    if re . match (pat, line . lower ()) and len (line) > len (longest):
        longest = line

print (longest)
