#!/opt/local/bin/python

#
# See ../README.md
#

#
# Run as: python ch-2.py < input-file
#

import fileinput

def reverse (num):
    rev = 0
    while num > 0:
        rev = rev * 10 + (num % 10)
        num = num // 10
    return rev


def ly (num):
    if num >= 10000000:
        return 1
    if num == reverse (num):
        return 0
    return ly (num + reverse (num))

for number in fileinput . input ():
    print (ly (int (number)))
