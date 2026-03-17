#!/usr/bin/env python3

# Perl Weekly Challenge 284 - Task 1 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-284/

import sys

ints = [int(x) for x in sys.argv[1:]]
count = {}
for x in ints:
    if x in count:
        count[x] += 1
    else:
        count[x] = 1
lucky = sorted(list(filter(lambda x:x == count[x], ints)))[::-1]
if len(lucky) > 0:
    print(lucky[0])
else:
    print(-1)
