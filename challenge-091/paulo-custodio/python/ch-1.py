#!/usr/bin/env python

# THE WEEKLY CHALLENGE - 091
# TASK #1: Count Number
#
# You are given a positive number $N. Write a script to count number and
# display as you read it.

# Solution with regular expressions:
# Just match the first digit and a sequence of equal matches, capture the
# results and show them.

import re
import sys

def count_number(n):
    n = str(n)
    out = ''
    while n != '':
        m = re.match(r'^((\d)\2*)', n)
        out += str(m.end())+m.group(2)
        n = n[m.end():]
    return out

print(count_number(int(sys.argv[1])))
