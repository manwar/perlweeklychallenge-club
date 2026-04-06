#!/usr/bin/env python3

# Perl Weekly Challenge 183 - Task 1 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-183/

def remove_dups(a):
    seen = set()
    a = [x for x in a if tuple(x) not in seen and not seen.add(tuple(x))]
    return a

import sys

in_data = [list(map(int, item.split(','))) for item in sys.argv[1:]]
out_data = remove_dups(in_data)
print("(", ", ".join([f"[{','.join(map(str, item))}]" for item in out_data]), ")", sep="")
