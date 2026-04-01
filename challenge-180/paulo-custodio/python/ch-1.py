#!/usr/bin/env python3

# Perl Weekly Challenge 180 - Task 1 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-180/

import sys
from collections import Counter

chars = list("".join(sys.argv[1:]))
count = Counter(chars)
pos = next((i for i in range(len(chars)) if count[chars[i]] == 1), None)
print(pos)
