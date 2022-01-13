#!/usr/bin/env python3

# Challenge 008
#
# Challenge #2
# Write a function, 'center', whose argument is a list of strings, which will
# be lines of text. The function should insert spaces at the beginning of the
# lines of text so that if they were printed, the text would be centered, and
# return the modified lines.

import sys

def center(lines):
    max_len = max([len(x) for x in lines])
    for i in range(len(lines)):
        lines[i] = " "*int((max_len-len(lines[i]))/2) + lines[i]
    return lines

lines = center(sys.argv[1:])
for line in lines:
    print(line)
