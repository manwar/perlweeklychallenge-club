#!/usr/bin/env python3

# Perl Weekly Challenge 280 - Task 1 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-280/

import sys

def double_letter(s):
    found = {}
    for char in s:
        if char in found:
            return char
        found[char] = True
    return ""

print(double_letter(sys.argv[1]))
