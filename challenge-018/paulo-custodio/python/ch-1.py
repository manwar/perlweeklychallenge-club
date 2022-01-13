#!/usr/bin/python3

# Challenge 018
#
# Task #1
# Write a script that takes 2 or more strings as command line parameters and
# print the longest common substring. For example, the longest common substring
# of the strings "ABABC", "BABCA" and "ABCBA" is string "ABC" of length 3.
# Other common substrings are "A", "AB", "B", "BA", "BC" and "C". Please check
# this wiki page for details.

import sys
import re

def longest_substr(strs):
    def matches_all(substr, strs):
        for s in strs:
            if not re.search(substr, s):
                return False
        return True

    longest_len = -1
    longest = set()

    for s in strs:
        for start in range(0, len(s)):
            for end in range(start+1, len(s)+1):
                if end-start >= longest_len:
                    substr = s[start:end]
                    if substr not in longest:
                        if matches_all(substr, strs):
                            if end-start == longest_len:
                                longest.add(substr)
                            else:
                                longest = set([substr])
                                longest_len = end-start
    return sorted(list(longest))

print("("+", ".join(['"'+x+'"' for x in longest_substr(sys.argv[1:])])+")")
