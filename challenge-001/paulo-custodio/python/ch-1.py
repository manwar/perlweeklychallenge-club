#!/usr/bin/env python

# Perl Weekly Challenge 001 - Task 1 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-001/

import sys

str = " ".join(sys.argv[1:])
print(str.count('e'), str.replace('e', 'E'))
