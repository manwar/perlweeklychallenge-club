#!/opt/local/bin/python

#
# See ../README.md
#

#
# Run as: python ch-2.py < input-file
#

import fileinput

DIFF_PER_MINUTE =  11
MIN_PER_HOUR    =  60
FULL_CIRCLE     = 720

for line in fileinput . input ():
    hours, minutes = line . strip () . split (":")
    angle = (DIFF_PER_MINUTE * (int (hours) * MIN_PER_HOUR + int (minutes))) \
                                            % FULL_CIRCLE
    if 2 * angle >= FULL_CIRCLE:
        angle = FULL_CIRCLE - angle

    print (int (angle / 2), end = '')
    if angle % 2:
        print (".5", end = '')
    print ("")
