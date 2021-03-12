#!/usr/bin/env python

# Challenge 102
#
# TASK #1 > Rare Numbers
# Submitted by: Mohammad S Anwar
#
# You are given a positive integer $N.
#
# Write a script to generate all Rare numbers of size $N if exists. Please
# checkout the page for more information about it.
# Examples
#
# (a) 2 digits: 65
# (b) 6 digits: 621770
# (c) 9 digits: 281089082

import sys
import math

def perfect_square(n):
    sq = math.sqrt(float(n))
    if math.floor(sq) == sq:
        return True
    else:
        return False

def print_rare(n):
    for r in range(10**(n-1), 10**n):
        r1 = int(str(r)[::-1])
        if perfect_square(r+r1):
            if r>=r1:
                if perfect_square(r-r1):
                    print(r)

print_rare(int(sys.argv[1]))
