#!/opt/local/bin/python

#
# See ../README.md
#

#
# Run as: python ch-1.py < input-file
#

import fileinput

SUNDAY    = 0
MONDAY    = 1
TUESDAY   = 2
WEDNESDAY = 3
THURSDAY  = 4
FRIDAY    = 5
SATURDAY  = 6

lookup    = [
    [261, 260, 260, 261, 261, 261, 261],   # Regular years
    [262, 261, 260, 261, 262, 262, 262],   # Leap years
]


def doomsday (year):
    anchor = [TUESDAY, SUNDAY, FRIDAY, WEDNESDAY] [(year // 100) % 4]
    y      = year % 100
    return (((y // 12) + (y % 12) + ((y % 12) // 4)) + anchor) % 7


def is_leap (year):
    if (year % 400 == 0) or (year % 4 == 0) and (year % 100 != 0):
        return 1
    return 0

for line in fileinput . input ():
    year = int (line)
    print (lookup [is_leap (year)] [doomsday (year)])
