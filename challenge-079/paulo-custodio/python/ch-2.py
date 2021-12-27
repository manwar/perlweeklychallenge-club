#!/usr/bin/python3

# Challenge 079
#
# TASK #2 > Trapped Rain Water
# Submitted by: Mohammad S Anwar
# You are given an array of positive numbers @N.
#
# Write a script to represent it as Histogram Chart and find out how much water
# it can trap.
#
# Example 1:
# Input: @N = (2, 1, 4, 1, 2, 5)
# The histogram representation of the given array is as below.
#      5           #
#      4     #     #
#      3     #     #
#      2 #   #   # #
#      1 # # # # # #
#      _ _ _ _ _ _ _
#        2 1 4 1 2 5
# Looking at the above histogram, we can see, it can trap 1 unit of rain water
# between 1st and 3rd column. Similary it can trap 5 units of rain water
# between 3rd and last column.
#
# Therefore your script should print 6.
#
# Example 2:
# Input: @N = (3, 1, 3, 1, 1, 5)
# The histogram representation of the given array is as below.
#      5           #
#      4           #
#      3 #   #     #
#      2 #   #     #
#      1 # # # # # #
#      _ _ _ _ _ _ _
#        3 1 3 1 1 5
# Looking at the above histogram, we can see, it can trap 2 units of rain water
# between 1st and 3rd column. Also it can trap 4 units of rain water between
# 3rd and last column.
#
# Therefore your script should print 6.

import sys
import re

# draw histogram
def draw_hist(n):
    max_height = max(n)
    hist = []
    for row in range(max_height):
        height = max_height-row
        line = ""
        for col in range(len(n)):
            if n[col]>=height:
                line += "#"
            else:
                line += " "
        hist.append(line)
    return hist

# fill buckets with water
def fill_watter(hist):
    for i in range(len(hist)):
        while True:
            matches = re.search(r"#( +)#", hist[i])
            if not matches:
                break
            hist[i] = hist[i][:matches.start(1)] + \
                      "w"*(matches.end(1)-matches.start(1)) + \
                      hist[i][matches.end(1):]
    return hist

# count water buckets
def count_watter(hist):
    count = 0
    for row in hist:
        row, watter = re.subn(r"w", r"w", row)
        count += watter
    return count

print(count_watter(fill_watter(draw_hist([int(x) for x in sys.argv[1:]]))))
