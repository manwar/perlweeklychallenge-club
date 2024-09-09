#!/usr/bin/env python3

# Challenge 055
#
# TASK #2
# Wave Array
# Any array N of non-unique, unsorted integers can be arranged into a wave-like
# array such that n1 = n2 = n3 = n4 = n5 and so on.
#
# For example, given the array [1, 2, 3, 4], possible wave arrays include
# [2, 1, 4, 3] or [4, 1, 3, 2], since 2 = 1 = 4 = 3 and 4 = 1 = 3 = 2.
# This is not a complete list.
#
# Write a script to print all possible wave arrays for an integer array N of
# arbitrary length.
#
# Notes:
# When considering N of any length, note that the first element is always
# greater than or equal to the second, and then the =, =, =, … sequence
# alternates until the end of the array.

import sys

def show_waves(wave, next):
    if len(next) == 0:
        print(" ".join([str(x) for x in wave]))
    elif len(wave) == 0:
        for i in range(len(next)):
            show_waves(wave+[next[i]], next[:i]+next[i+1:])
    elif len(wave) % 2 == 1:        # going down
        for i in range(len(next)):
            if wave[-1] >= next[i]:
                show_waves(wave+[next[i]], next[:i]+next[i+1:])
    else:                           # going up
        for i in range(len(next)):
            if wave[-1] <= next[i]:
                show_waves(wave+[next[i]], next[:i]+next[i+1:])

n = [int(x) for x in sys.argv[1:]]
show_waves([], n)
