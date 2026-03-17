#!/usr/bin/env python3

# Perl Weekly Challenge 286 - Task 2 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-286/

import sys

def reduce(nums):
    out = []
    while len(nums) > 0:
        if len(nums) >= 2:
            out.append(min(nums[0], nums[1]))
        if len(nums) >= 4:
            out.append(max(nums[2], nums[3]))
        nums = nums[4:]
    return out

nums = list(map(int, sys.argv[1:]))
while len(nums) > 1:
    nums = reduce(nums)

print(nums[0])
