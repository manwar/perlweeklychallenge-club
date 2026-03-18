#!/usr/bin/env python3

# Perl Weekly Challenge 285 - Task 1 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-285/

import sys

def endpoints(routes):
    endp = {}
    for p in routes:
        if not p[1] in endp:
            endp[p[1]] = 1
    for p in routes:
        if p[0] in endp:
            del endp[p[0]]
    return sorted(list(endp.keys()))

pairs = (" ".join(sys.argv[1:])).split(",")
routes = [x.split() for x in pairs]
print(", ".join(endpoints(routes)))
