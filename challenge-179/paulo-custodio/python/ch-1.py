#!/usr/bin/env python3

# Perl Weekly Challenge 179 - Task 1 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-179/

from num2words import num2words
import sys

print(num2words(int(sys.argv[1]), to='ordinal'))
