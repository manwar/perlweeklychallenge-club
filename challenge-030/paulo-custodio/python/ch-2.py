#!/usr/bin/python3

# Challenge 030
#
# Task #2
# Write a script to print all possible series of 3 positive numbers, where in
# each series at least one of the number is even and sum of the three numbers
# is always 12. For example, 3,4,5.

import sys

S = int(sys.argv[1])

for i in range(1, S+1):
    for j in range(i+1, S+1):
        for k in range(j+1, S+1):
            if sum([i, j, k]) == S:
                if any([x%2==0 for x in [i, j, k]]):
                    print(f"{i},{j},{k}")
