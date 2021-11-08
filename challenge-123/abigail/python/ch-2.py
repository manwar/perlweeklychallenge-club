#!/opt/local/bin/python

#
# See ../README.md
#

#
# Run as: python ch-2.py < input-file
#

import fileinput

def dist (x1, y1, x2, y2):
    return (x1 - x2) ** 2 + (y1 - y2) ** 2

for line in fileinput . input ():
    [x1, y1, x2, y2, x3, y3, x4, y4] = \
         map (lambda x: int (x), line . split (' '))
    if dist (x1, y1, x2, y2) == dist (x2, y2, x3, y3) ==  \
       dist (x3, y3, x4, y4) == dist (x4, y4, x1, y1) and \
       dist (x1, y1, x3, y3) == dist (x2, y2, x4, y4):
        print (1)
    else:
        print (0)
        
