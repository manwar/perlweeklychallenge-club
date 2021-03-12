#!/usr/bin/env python

# Challenge 099
#
# TASK #1 > Pattern Match
# Submitted by: Mohammad S Anwar
# You are given a string $S and a pattern $P.
#
# Write a script to check if given pattern validate the entire string.
# Print 1 if pass otherwise 0.
#
# The patterns can also have the following characters:
#
# ? - Match any single character.
# * - Match any sequence of characters.
# Example 1:
# Input: $S = "abcde" $P = "a*e"
# Output: 1
# Example 2:
# Input: $S = "abcde" $P = "a*d"
# Output: 0
# Example 3:
# Input: $S = "abcde" $P = "?b*d"
# Output: 0
# Example 4:
# Input: $S = "abcde" $P = "a*c?e"
# Output: 1

import sys

def match(s, p):
    while True:
        if s=="" and p=="":
            return True
        elif s=="" or p=="":
            return False
        elif p[0]=="?":
            s=s[1:]
            p=p[1:]
        elif p[0]=="*":
            p=p[1:]
            for i in range(0, len(s)):
                if match(s[i:], p):
                    return True
            return False
        elif s[0]!=p[0]:
            return False
        else:
            s=s[1:]
            p=p[1:]

if match(sys.argv[1], sys.argv[2]):
    print(1)
else:
    print(0)
