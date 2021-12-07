#!/usr/bin/env python3

# Challenge 127
#
# TASK #2 > Conflict Intervals
# Submitted by: Mohammad S Anwar
# You are given a list of intervals.
#
# Write a script to find out if the current interval conflicts with any of the
# previous intervals.
#
# Example
# Input: @Intervals = [ (1,4), (3,5), (6,8), (12, 13), (3,20) ]
# Output: [ (3,5), (3,20) ]
#
#     - The 1st interval (1,4) do not have any previous intervals to compare
#       with, so skip it.
#     - The 2nd interval (3,5) does conflict with previous interval (1,4).
#     - The 3rd interval (6,8) do not conflicts with any of the previous intervals
#       (1,4) and (3,5), so skip it.
#     - The 4th interval (12,13) again do not conflicts with any of the previous
#       intervals (1,4), (3,5) and (6,8), so skip it.
#     - The 5th interval (3,20) conflicts with the first interval (1,4).
#
# Input: @Intervals = [ (3,4), (5,7), (6,9), (10, 12), (13,15) ]
# Output: [ (6,9) ]
#
#     - The 1st interval (3,4) do not have any previous intervals to compare
#       with, so skip it.
#     - The 2nd interval (5,7) do not conflicts with the previous interval (3,4),
#       so skip it.
#     - The 3rd interval (6,9) does conflict with one of the previous intervals (5,7).
#     - The 4th interval (10,12) do not conflicts with any of the previous
#       intervals (3,4), (5,7) and (6,9), so skip it.
#     - The 5th interval (13,15) do not conflicts with any of the previous
#       intervals (3,4), (5,7), (6,9) and (10,12), so skip it.

import sys

def parse_intervals(args):
    args = [int(x) for x in args]
    out = []
    while args:
        out.append([args.pop(0), args.pop(0)])
    return out

def find_conflicts(intervals):
    conflicts = []
    for i in range(1, len(intervals)):
        for j in range(0, i):
            i1s = intervals[i][0]
            i1e = intervals[i][1]
            i2s = intervals[j][0]
            i2e = intervals[j][1]
            if (i1s >= i2s and i1s <  i2e) or \
               (i1e >= i2s and i1e <  i2e) or \
               (i1s <  i2s and i1e >= i2e):
                conflicts.append(intervals[i])
                break;
    return conflicts

def intervals_as_string(intervals):
    out = "[ "
    sep = ""
    for interval in intervals:
        out += f"{sep}({interval[0]},{interval[1]})"
        sep = ", "
    out += " ]"
    return out

intervals = parse_intervals(sys.argv[1:])
conflicts = find_conflicts(intervals)
print(intervals_as_string(conflicts))
