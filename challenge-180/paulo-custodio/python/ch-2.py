#!/usr/bin/env python3

# Perl Weekly Challenge 180 - Task 2 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-180/

import sys

if len(sys.argv) <= 2:
    raise ValueError("usage: ch-2.py list... i")

list_values = list(map(int, sys.argv[1:-1]))
i = int(sys.argv[-1])
print("("+(", ".join(str(x) for x in list_values if x > i))+")")
