#!/usr/bin/env python

# Challenge 096
#
# TASK #2 > Edit Distance
# Submitted by: Mohammad S Anwar
# You are given two strings $S1 and $S2.
#
# Write a script to find out the minimum operations required to convert $S1
# into $S2. The operations can be insert, remove or replace a character. Please
# check out Wikipedia page for more information.
#
# Example 1:
# Input: $S1 = "kitten"; $S2 = "sitting"
# Output: 3
#
# Operation 1: replace 'k' with 's'
# Operation 2: replace 'e' with 'i'
# Operation 3: insert 'g' at the end
# Example 2:
# Input: $S1 = "sunday"; $S2 = "monday"
# Output: 2
#
# Operation 1: replace 's' with 'm'
# Operation 2: replace 'u' with 'o'

import sys

def wag_fis_dist(a, b):

    # define a table where d[i,j] is the Levenshtein distance between
    # first i chars of a and first j chars of b
    d = [ [ 0 for j in range(0, len(b)+1) ] for i in range(0, len(a)+1) ]

    # source prefixes can be transformed into empty string by dropping chars
    for i in range(1, len(a)+1):
        d[i][0] = i

    # target prefixes can be reached from empty source prefix by inserting chars
    for j in range(1, len(b)+1):
        d[0][j] = j

    # flood-fill the rest of the table
    for j in range(1, len(b)+1):
        for i in range(1, len(a)+1):
            subst_cost = 0 if a[i-1] == b[j-1] else 1
            d[i][j] = min(d[i-1][j]+1,              # deletion
                          d[i][j-1]+1,              # insertion
                          d[i-1][j-1]+subst_cost)   # substitution

    # distance is in lower bottom cell
    return d[len(a)][len(b)]

a, b = tuple(sys.argv[1:3])
print(wag_fis_dist(a, b))
