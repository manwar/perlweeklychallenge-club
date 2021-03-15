#!/opt/local/bin/python

#
# See ../READ.md
#

#
# Run as python ch-1.py < input-file
#

import fileinput

for line in fileinput . input ():
    max = int (line)
    #
    # Python does not have a for (;;) style loop
    #
    base2 = 1
    while base2 <= max:
        base3 = base2
        while base3 <= max:
            base5 = base3
            while base5 <= max:
                print base5
                base5 *= 5
            base3 *= 3
        base2 *= 2
