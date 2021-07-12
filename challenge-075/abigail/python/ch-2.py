#!/opt/local/bin/python

#
# See ../README.md
#

#
# Run as: python ch-2.py < input-file
#

import fileinput

for line in fileinput . input ():
    heights = list (map (lambda _: int (_), line . split (" ")))
    max_height = max (heights)

    max_area = 0
    for h in range (1, max_height + 1):
        xam = 0   # max clashes with function max()
        cur = 0
        for i in range (0, len (heights)):
            if heights [i] >= h:
                cur = cur + 1
            else:
                if xam < cur:
                   xam = cur
                cur = 0
        if xam < cur:
           xam = cur

        area = xam * h
        if max_area < area:
           max_area = area

    print (max_area)
