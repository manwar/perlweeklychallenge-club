#!/usr/bin/env python

# Challenge 099
#
# TASK #2 > Unique Sub-sequence
# Submitted by : Mohammad S Anwar
# You are given two strings $S and $T.
#
# Write a script to find out count of different unique sub-sequences matching
# $T without changing the position of characters.
#
# Example 1:
# Input : $S = "littleit', $T = 'lit'
# Output : 5
#
#     1: [lit] tleit
#     2: [li] t[t] leit
#     3: [li] ttlei[t]
#     4: litt[l] e[it]
#     5: [l] ittle[it]
# Example 2:
# Input : $S = "london', $T = 'lon'
# Output : 3
#
#     1: [lon] don
#     2: [lo] ndo[n]
#     3: [l] ond[on]

import sys

def count_subsequences(s, t):
    while True:
        if t=="":
            return 1
        elif s=="":
            return 0
        elif s[0]==t[0]:
            return (count_subsequences(s[1:], t[1:]) +
                    count_subsequences(s[1:], t))
        else:
            s=s[1:]

print(count_subsequences(sys.argv[1], sys.argv[2]))
