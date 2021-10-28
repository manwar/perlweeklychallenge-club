#!/usr/bin/env python3

# TASK #2 > Tug of War
# Submitted by: Mohammad S Anwar
# You are given a set of $n integers (n1, n2, n3, ...).
#
# Write a script to divide the set in two subsets of n/2 sizes each so that
# the difference of the sum of two subsets is the least. If $n is even then
# each subset must be of size $n/2 each. In case $n is odd then one subset
# must be ($n-1)/2 and other must be ($n+1)/2.
#
# Example
# Input:        Set = (10, 20, 30, 40, 50, 60, 70, 80, 90, 100)
# Output:  Subset 1 = (30, 40, 60, 70, 80)
#          Subset 2 = (10, 20, 50, 90, 100)
#
# Input:        Set = (10, -15, 20, 30, -25, 0, 5, 40, -5)
#          Subset 1 = (30, 0, 5, -5)
#          Subset 2 = (10, -15, 20, -25, 40)

import sys
from itertools import combinations

def divide(nums):
    def print_set(s):
        s.sort()
        print("(" + ", ".join([str(x) for x in s]) + ")")

    goal = sum(nums)/2
    k = int(len(nums)/2)
    cur_subset = []
    cur_dist = goal*2

    for subset in combinations(nums, k):
        subset = list(subset)
        dist = abs(sum(subset)-goal)
        if dist < cur_dist:
            cur_subset, cur_dist = subset, dist

    other_subset = list(set(nums) - set(cur_subset))
    print_set(cur_subset)
    print_set(other_subset)

divide([int(x) for x in sys.argv[1:]])
