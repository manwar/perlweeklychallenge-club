#!/opt/local/bin/python

#
# See ../README.md
#

#
# Run as: python ch-1.py < input-file
#

import fileinput

for line in fileinput . input ():
    result = 0
    seen_one = False
    for digit in list (line . strip ()):
        result = result * 9
        if seen_one:
            result = result + 8
        elif digit == "1":
            seen_one = True
        elif digit != "0":
            result = result + int (digit) - 1
    print (result)
