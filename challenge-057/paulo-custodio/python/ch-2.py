#!/usr/bin/env python3

# Challenge 057
#
# TASK #2 › Shortest Unique Prefix
# Write a script to find the shortest unique prefix for each each word in the
# given list. The prefixes will not necessarily be of the same length.
#
# Sample Input
#     [ "alphabet", "book", "carpet", "cadmium", "cadeau", "alpine" ]
# Expected Output
#     [ "alph", "b", "car", "cadm", "cade", "alpi" ]

import re
import sys

def shortest_prefix1(word, words):
    for i in range(1, len(word)):
        prefix = word[:i]
        found = 0
        for x in words:
            if re.search(r'^'+prefix, x):
                found += 1
        if found == 1:
            return prefix
    return word

def shortest_prefix(words):
    prefixes = []
    for word in words:
        prefixes.append(shortest_prefix1(word, words))
    return prefixes

print(" ".join(shortest_prefix(sys.argv[1:])))
