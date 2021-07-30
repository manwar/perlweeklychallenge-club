#!/opt/local/bin/python

#
# See ../README.md
#

#
# Run as: python ch-2.py < input-file
#

import fileinput

for line in fileinput . input ():
    [x1, y1, x2, y2, x3, y3, x4, y4] = \
         map (lambda x: int (x), line . split (' '))
    if (x1 - x2) ** 2 + (y1 - y2) ** 2 ==   \
       (x2 - x3) ** 2 + (y2 - y3) ** 2 ==   \
       (x3 - x4) ** 2 + (y3 - y4) ** 2 ==   \
       (x4 - x1) ** 2 + (y4 - y1) ** 2 and  \
       (x1 - x3) ** 2 + (y1 - y3) ** 2 ==   \
       (x2 - x4) ** 2 + (y2 - y4) ** 2:
        print (1)
    else:
        print (0)
        
