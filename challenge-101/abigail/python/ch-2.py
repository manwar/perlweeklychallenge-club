#!/opt/local/bin/python

#
# See ../README.md
#

#
# Run as python ch-2.py < input-file
#

import fileinput

#
# This determines on which side of the line through (x1, y1) and
# (x2, y2) the origin lies. If > 0, then the origin lies to the left
# of the line, if < 0, the origin lies to the right of the line, if
# = 0, the origin lies on the line.
#
def side (x1, y1, x2, y2):
    return (y2 - y1) * x2 - (x2 - x1) * y2


for line in fileinput . input ():
    #
    # Parse input. We need an explicite conversion from strings to floats
    #
    x1, y1, x2, y2, x3, y3 = map (lambda f: float (f), line . split ())

    #
    # Determine where the origin is relative to the three lines 
    # through the vertices of the triangle. Note we have to go
    # in a specific order through the points. (Either clock wise,
    # or counter clockwise, as long as we're consistent).
    #
    s1 = side (x2, y2, x3, y3)
    s2 = side (x3, y3, x1, y1)
    s3 = side (x1, y1, x2, y2)

    #
    # If the origin either lies to the left (or on) each of the
    # lines, or to the right (or on) each of the lines, the origin
    # lies inside the triangle. If not, it does not.
    #
    if s1 <= 0 and s2 <= 0 and s3 <= 0 or \
       s1 >= 0 and s2 >= 0 and s3 >= 0:
        print (1)
    else:
        print (0)
