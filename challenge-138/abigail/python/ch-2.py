#!/opt/local/bin/python

#
# See ../README.md
#

#
# Run as: python ch-2.py < input-file
#

import fileinput
import math

def can_split (target, number):
    if target >  number or target < 0:
        return 0
    if target == number:
        return 1

    pow_10 = 10

    while pow_10 <= number:
        if can_split (target - (number % pow_10), number // pow_10):
            return 1
        pow_10 = 10 * pow_10

    return 0

for number in fileinput . input ():
    number = int (number)
    if number > 1 and can_split (int (math . sqrt (number)), number):
        print (1)
    else:
        print (0)
