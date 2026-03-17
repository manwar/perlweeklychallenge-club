#!/usr/bin/env python3

# Perl Weekly Challenge 292 - Task 1 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-292/

import sys

nums = sorted([[i-1, int(sys.argv[i])] for i in range(1, len(sys.argv))], key=lambda x: x[1], reverse=True)
if len(nums) >= 2 and nums[0][1] >= 2 * nums[1][1]:
    print(nums[0][0])
else:
    print(-1)
