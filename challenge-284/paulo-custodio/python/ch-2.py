#!/usr/bin/env python3

# Perl Weekly Challenge 284 - Task 2 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-284/

import sys

args = (" ".join(sys.argv[1:])).split(',')
list1 = [int(x) for x in args[0].split()]
list2 = [int(x) for x in args[1].split()]

output = []
while len(list2) > 0:
    n = list2[0]
    list2 = list2[1:]
    for x in filter(lambda x:x == n, list1):
        output.append(x)
    list1 = list(filter(lambda x:x != n, list1))
for x in sorted(list1):
    output.append(x)

print("("+", ".join([str(x) for x in output])+")")
