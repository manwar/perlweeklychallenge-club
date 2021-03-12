#!/usr/bin/env python

# Challenge 092
#
# TASK #2 > Insert Interval
# Submitted by: Mohammad S Anwar
# You are given a set of sorted non-overlapping intervals and a new interval.
#
# Write a script to merge the new interval to the given set of intervals.
#
# Example 1:
# Input $S = (1,4), (8,10); $N = (2,6)
# Output: (1,6), (8,10)
# Example 2:
# Input $S = (1,2), (3,7), (8,10); $N = (5,8)
# Output: (1,2), (3,10)
# Example 3:
# Input $S = (1,5), (7,9); $N = (10,11)
# Output: (1,5), (7,9), (10,11)

import sys

def add_interval_in_order(intervals, a, b):
    if len(intervals)==0:
        intervals.append([a, b])
    else:
        for i in range(0, len(intervals)):
            if b < intervals[i][0]:                 # before, not overlapping
                intervals = intervals[:i]+[a, b]+intervals[i:]
                return intervals
            elif b >= intervals[i][0] and b < intervals[i][1]:  # end within
                if a < intervals[i][0]:                         # merge start
                    intervals[i][0] = a
                return intervals
            elif b >= intervals[i][1] and a < intervals[i][1]:  # end after, start within
                intervals[i][1] = b
                if a < intervals[i][0]:                         # merge start
                    intervals[i][0] = a
                return intervals
        intervals.append([a, b])                                # append to end
    return intervals

def merge_intervals(intervals):
    i = 0
    while i+1 < len(intervals):
        while i+1 < len(intervals):
            this = intervals[i]
            next = intervals[i+1]
            if this[1] < next[0]:       # not overlapping
                break                   # next interval
            else:
                intervals = intervals[:i]+ \
                            [[this[0], next[1]]]+ \
                            intervals[i+2:]     # merge and test again
        i += 1
    return intervals

def add_interval(intervals, a, b):
    intervals = add_interval_in_order(intervals, a, b)
    intervals = merge_intervals(intervals)
    return intervals

def add_intervals():
    intervals = []
    for i in range(1, len(sys.argv)):
        a, b = sys.argv[i].split(',')
        intervals = add_interval(intervals, int(a), int(b))
    return intervals

def intervals_str(intervals):
    out = ''
    for i in range(0, len(intervals)):
        out += '('+str(intervals[i][0])+','+str(intervals[i][1])+')'
        if i<len(intervals)-1:
            out += ', '
    return out

print(intervals_str(add_intervals()))
