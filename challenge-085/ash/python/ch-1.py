#!/usr/bin/env python3
#
# Task 1 from
# https://perlweeklychallenge.org/blog/perl-weekly-challenge-085/#TASK1

from itertools import combinations

r = [1.2, 0.4, 0.1, 2.5]
# r = [0.2, 1.5, 0.9, 1.1]

for row in combinations(r, 3):
    if 1 < sum(row) < 2:
        print(1)
        break
else:
    print(0)
