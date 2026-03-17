#!/usr/bin/env python3

# Perl Weekly Challenge 283 - Task 2 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-283/

import sys

def digit_count_true(ints):
    count = {}
    for i in range(len(ints)):
        count[i] = 0
    for x in ints:
        if x in count:
            count[x] += 1
        else:
            count[x] = 1
    for i in range(len(ints)):
        if count[i] != ints[i]:
            return False
    return True

ints = [int(x) for x in sys.argv[1:]]
print('true' if digit_count_true(ints) else 'false')
