#!/usr/bin/env python

# THE WEEKLY CHALLENGE - 091
# TASK #2: Jump Game
#
# You are given an array of positive numbers @N, where value at each index
# determines how far you are allowed to jump further. Write a script to decide
# if you can jump to the last index. Print 1 if you are able to reach the last
# index otherwise 0.

import sys

n = [int(x) for x in sys.argv[1:]]
pos = 0
while pos < len(n)-1 and n[pos] != 0:
    pos += n[pos]
if pos==len(n)-1:
    print(1)
else:
    print(0)
