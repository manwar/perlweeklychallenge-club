#!/opt/local/bin/python

#
# See ../README.md
#

#
# Run as python ch-2.py < input-file
#

import fileinput
import re

numbers = []

#
# Read in the data
#
for line in fileinput . input ():
    numbers . append (list (map (lambda x: int (x),
                                 re . compile (r'\s+')
                                    . split (line . strip ()))))


#
# Calculate the minimum path, bottom to top
#
for x in range (len (numbers) - 2, -1, -1):
    for y in range (0, len (numbers [x])):
        numbers [x] [y] = numbers [x] [y] + min (numbers [x + 1] [y],
                                                 numbers [x + 1] [y + 1])

#
# Print result
#
print (numbers [0] [0])
