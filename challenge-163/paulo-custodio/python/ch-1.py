#!/usr/bin/env python3

# Perl Weekly Challenge 163 - Task 1 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-163/

def sum_biwise_and(*n):
    total_sum = 0
    for i in range(len(n) - 1):
        for j in range(i + 1, len(n)):
            total_sum += n[i] & n[j]
    return total_sum

import sys
print(sum_biwise_and(*map(int, sys.argv[1:])))
