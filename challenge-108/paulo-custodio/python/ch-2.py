#!/usr/bin/env python3

# Challenge 108
#
# TASK #2 - Bell Numbers
# Submitted by: Mohammad S Anwar
#
# Write a script to display top 10 Bell Numbers. Please refer to wikipedia page
# for more informations.
#
# Example:
# B0: 1 as you can only have one partition of zero element set
# B1: 1 as you can only have one partition of one element set {a}.
# B2: 2
#    {a}{b}
#    {a,b}
# B3: 5
#    {a}{b}{c}
#    {a,b}{c}
#    {a}{b,c}
#    {a,c}{b}
#    {a,b,c}
# B4: 15
#    {a}{b}{c}{d}
#    {a,b,c,d}
#    {a,b}{c,d}
#    {a,c}{b,d}
#    {a,d}{b,c}
#    {a,b}{c}{d}
#    {a,c}{b}{d}
#    {a,d}{b}{c}
#    {b,c}{a}{d}
#    {b,d}{a}{c}
#    {c,d}{a}{b}
#    {a}{b,c,d}
#    {b}{a,c,d}
#    {c}{a,b,d}
#    {d}{a,b,c}

import sys

def bell_numbers():
    n = -1
    bell = []
    while True:
        n += 1
        if n==0:
            bell.append([1])
            yield 1
        else:
            bell.append([bell[n-1][n-1]])
            for i in range(1, n+1):
                bell[n].append(bell[n-1][i-1] + bell[n][i-1])
            yield bell[n][0]

count = int(sys.argv[1])
bell = []
for n in bell_numbers():
    if count<=0:
        break
    bell.append(n)
    count -= 1
print(" ".join([str(x) for x in bell]))
