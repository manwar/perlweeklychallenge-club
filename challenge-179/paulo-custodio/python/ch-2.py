#!/usr/bin/env python3

# Perl Weekly Challenge 179 - Task 2 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-179/

import sys

bars = ["\u2581", "\u2582", "\u2583", "\u2584", "\u2585", "\u2586", "\u2587", "\u2588"]

nums = list(map(int, sys.argv[1:]))
max_num = max(nums)
height = [int((num / max_num) * 7) for num in nums]
chars = [bars[h] for h in height]
print(''.join(chars))
