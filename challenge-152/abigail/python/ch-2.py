#!/usr/local/bin/python3

#
# See https://theweeklychallenge.org/blog/perl-weekly-challenge-152
#

#
# Run as: python ch-2.py < input-file
#

import fileinput

for line in fileinput . input ():
    [a_x1, a_y1, a_x2, a_y2, b_x1, b_y1, b_x2, b_y2] = \
        [int (x) for x in line . split ()]
    print (  (max (a_x1, a_x2) - min (a_x1, a_x2))  *  \
             (max (a_y1, a_y2) - min (a_y1, a_y2))  +  \
             (max (b_x1, b_x2) - min (b_x1, b_x2))  *  \
             (max (b_y1, b_y2) - min (b_y1, b_y2))  -  \
 max (0, min (max (a_x1, a_x2),  max (b_x1, b_x2))  -  \
         max (min (a_x1, a_x2),  min (b_x1, b_x2))) *  \
 max (0, min (max (a_y1, a_y2),  max (b_y1, b_y2))  -  \
         max (min (a_y1, a_y2),  min (b_y1, b_y2))))
