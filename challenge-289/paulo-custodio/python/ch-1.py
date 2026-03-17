#!/usr/bin/env python3

# Perl Weekly Challenge 289 - Task 1 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-289/

import sys

nums = sorted(set(map(int, sys.argv[1:])), reverse=True)
print(nums[2] if len(nums) > 2 else nums[0])
