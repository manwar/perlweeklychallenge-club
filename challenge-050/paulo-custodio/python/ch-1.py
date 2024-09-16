#!/usr/bin/env python3

# Challenge 050
#
# TASK #1
# Merge Intervals
# Write a script to merge the given intervals where ever possible.
#
# [2,7], [3,9], [10,12], [15,19], [18,22]
#
# The script should merge [2, 7] and [3, 9] together to return [2, 9].
#
# Similarly it should also merge [15, 19] and [18, 22] together to return
# [15, 22].
#
# The final result should be something like below:
#
# [2, 9], [10, 12], [15, 22]

import sys

def merge_intervals(intervals):
    done = False
    while not done:
        done = True
        for i in range(len(intervals)-1):
            a = intervals[i]
            b = intervals[i+1]
            if a[1] >= b[0]:
                a[1] = max(a[1], b[1])
                intervals = intervals[0:i+1] + intervals[i+2:]
                done = False
                break
    return intervals

intervals = []
for i in range(1, len(sys.argv), 2):
    intervals.append([int(sys.argv[i]), int(sys.argv[i+1])])

merged = merge_intervals(intervals)
print(", ".join("["+str(x[0])+", "+str(x[1])+"]" for x in merged))
