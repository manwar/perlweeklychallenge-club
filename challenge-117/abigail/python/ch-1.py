#!/opt/local/bin/python

#
# See ../README.md
#

#
# Run as: python ch-1.py < input-file
#

import fileinput

sum = 0
SUM_15 = 120

for line in fileinput . input ():
    sum = sum + int ((line . split (",")) [0])

print (SUM_15 - sum)
