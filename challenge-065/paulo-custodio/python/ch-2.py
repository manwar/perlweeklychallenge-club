#!/usr/bin/env python3

# Challenge 065
#
# TASK #2 > Palindrome Partition
# Submitted by: Mohammad S Anwar
# Reviewed by: Ryan Thompson
#
# You are given a string $S. Write a script print all possible partitions that
# gives Palindrome. Return -1 if none found.
#
# Please make sure, partition should not overlap. For example, for given string
# "abaab", the partition "aba" and "baab" would not be valid, since they overlap.
#
# Example 1
# Input: $S = 'aabaab'
# Ouput:
#  There are 3 possible solutions.
#  a) 'aabaa'
#  b) 'aa', 'baab'
#  c) 'aba'
# Example 2
# Input: $S = 'abbaba'
# Output:
#  There are 3 possible solutions.
#  a) 'abba'
#  b) 'bb', 'aba'
#  c) 'bab'

import sys

def is_palindrome(s):
    return len(s) >= 2 and s == s[::-1]

def partitions(s):
    seen = set()
    length = len(s)
    for lead in range(length + 1):
        for p1 in range(2, length + 1):
            for p2 in [0] + list(range(2, length + 1)):
                for tail in range(length + 1):
                    if lead + p1 + p2 + tail != length:
                        continue
                    s1 = s[lead:lead+p1]
                    s2 = s[lead+p1:lead+p1+p2]
                    if is_palindrome(s1) and is_palindrome(s2):
                        key = f"{s1}, {s2}"
                        if key not in seen:
                            print(key)
                            seen.add(key)
                    elif is_palindrome(s1):
                        if s1 not in seen:
                            print(s1)
                            seen.add(s1)

partitions(sys.argv[1] if len(sys.argv) > 1 else "")
