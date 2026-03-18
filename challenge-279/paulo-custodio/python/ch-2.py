#!/usr/bin/env python3

# Perl Weekly Challenge 279 - Task 2 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-279/

import sys

str_input = " ".join(sys.argv[1:])
vowels = sum(1 for char in str_input if char in "aeiouAEIOU")
print("true" if vowels % 2 == 0 else "false")
