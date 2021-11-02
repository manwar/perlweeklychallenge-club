#!/usr/bin/env python3

# Challenge 117
#
# TASK #1 - Missing Row
# Submitted by: Mohammad S Anwar
# You are given text file with rows numbered 1-15 in random order but there
# is a catch one row in missing in the file.
#
# 11, Line Eleven
# 1, Line one
# 9, Line Nine
# 13, Line Thirteen
# 2, Line two
# 6, Line Six
# 8, Line Eight
# 10, Line Ten
# 7, Line Seven
# 4, Line Four
# 14, Line Fourteen
# 3, Line three
# 15, Line Fifteen
# 5, Line Five
# Write a script to find the missing row number.

import sys

rows = set(range(1, 16))
for line in sys.stdin:
    row = int(line.split(',')[0])
    if row in rows:
        rows.remove(row)
print(",".join([str(x) for x in list(rows)]))
