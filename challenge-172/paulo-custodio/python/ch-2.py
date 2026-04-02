#!/usr/bin/env python3

# Perl Weekly Challenge 172 - Task 2 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-172/

def median(n):
    if len(n) % 2 == 0:
        i = len(n) // 2
        return (n[i - 1] + n[i]) / 2
    else:
        return n[len(n) // 2]

def lower_quartile(n):
    return median(n[:len(n) // 2])

def upper_quartile(n):
    return median(n[len(n) // 2:])

def five_number_summary(n):
    n.sort()
    return (n[0], lower_quartile(n), median(n), upper_quartile(n), n[-1])

import sys
print("("+(", ".join([f"{x:.1f}" for x in five_number_summary(list(map(float, sys.argv[1:])))]))+")")
