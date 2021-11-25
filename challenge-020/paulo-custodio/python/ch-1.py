#!/usr/bin/python3

# Challenge 020
#
# Task #1
# Write a script to accept a string from command line and split it on change
# of character. For example, if the string is "ABBCDEEF", then it should split
# like "A", "BB", "C", "D", "EE", "F".

import sys
import re

str = sys.argv[1]
segs = []
while True:
    matches = re.match(r"((.)\2*)", str)
    if not matches:
        break
    segs.append(matches.group(1))
    str = str[matches.end(0):]

print(", ".join(['"'+x+'"' for x in segs]))
