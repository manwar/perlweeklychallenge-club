#!/usr/bin/env python3

# Challenge 115
#
# TASK #1 - String Chain
# Submitted by: Mohammad S Anwar
# You are given an array of strings.
#
# Write a script to find out if the given strings can be chained to form a
# circle. Print 1 if found otherwise 0.
#
# A string $S can be put before another string $T in circle if the last
# character of $S is same as first character of $T.
#
# Examples:
# Input: @S = ("abc", "dea", "cd")
# Output: 1 as we can form circle e.g. "abc", "cd", "dea".
#
# Input: @S = ("ade", "cbd", "fgh")
# Output: 0 as we can't form circle.

import sys

def is_circle(words):
    def worker(pending, path):
        found_solution = False
        if len(pending)==0:
            if not found_solution:
                found_solution = path[-1][-1] == path[0][0]
        else:
            for word in pending:
                if len(path)==0 or path[-1][-1] == word[0]:
                    new_pending = list(filter(lambda x:x != word, pending))
                    if not found_solution:
                        found_solution = worker(new_pending, [*path, word])
        return found_solution

    return worker(words, [])

if is_circle(sys.argv[1:]):
    print(1)
else:
    print(0)
