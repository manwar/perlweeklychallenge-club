#!/opt/local/bin/python

#
# See ../README.md
#

#
# Run as: python ch-1.py < input-file
#

import fileinput
import re

for line in fileinput . input ():
    numbers = {}
    for x in re . findall ('[1-9][0-9]*', line):
        if x in numbers:
            numbers [x] = numbers [x] + 1
        else:
            numbers [x] = 1
    for number in numbers:
        if numbers [number] % 2 == 1:
            print (number)
