#!/usr/bin/env python3

# Challenge 054
#
# TASK #1
# kth Permutation Sequence
# Write a script to accept two integers n (>=1) and k (>=1). It should print the
# kth permutation of n integers. For more information, please follow the wiki
# page.
#
# For example, n=3 and k=4, the possible permutation sequences are listed below:
#
# 123
# 132
# 213
# 231
# 312
# 321
# The script should print the 4th permutation sequence 231.

import sys
from itertools import permutations

n = int(sys.argv[1])
k = int(sys.argv[2])

perm = permutations([x for x in range(1, n+1)], k)
for i in list(perm):
    print("".join([str(x) for x in i]))
