#!/usr/bin/env python3

# TASK #1 > Average of Stream
# Submitted by: Mohammad S Anwar
# You are given a stream of numbers, @N.
#
# Write a script to print the average of the stream at every point.
#
# Example
# Input: @N = (10, 20, 30, 40, 50, 60, 70, 80, 90, ...)
# Output:      10, 15, 20, 25, 30, 35, 40, 45, 50, ...
#
# Average of first number is 10.
# Average of first 2 numbers (10+20)/2 = 15
# Average of first 3 numbers (10+20+30)/3 = 20
# Average of first 4 numbers (10+20+30+40)/4 = 25 and so on.

import sys

sum = 0
count = 0
for line in sys.stdin:
    sum += int(line)
    count += 1
    print("{:.2f}".format(sum/count))
