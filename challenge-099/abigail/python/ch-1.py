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
# Read a string and a pattern. Turn the pattern into a regular expression:
#    - '?'  becames '.'
#    - '*'  becomes '.*'
#    - any non-word character will be escaped
#
# Then map the string against the pattern, anchored
#
for line in fileinput . input ():
    (string, pattern) = re . split (r' +', line . strip ())
    pat = "^"
    for c in pattern:
        if c == "?":
            pat = pat + "."
        elif c == "*":
            pat = pat + ".*"
        elif re . match (r'\W', c):
            pat = pat + "\\" + c
        else:
            pat = pat + c
    pat = pat + "$"
    if re . match (pat, string):
        print (1)
    else:
        print (0)
