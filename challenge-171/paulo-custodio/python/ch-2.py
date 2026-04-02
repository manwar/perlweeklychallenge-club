#!/usr/bin/env python3

# Perl Weekly Challenge 171 - Task 2 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-171/

import sys

def compose(f, g):
    return lambda x: f(g(x))

def times3(x):
    return 3 * x

def times5(x):
    return 5 * x

h = compose(times3, times5)
print(h(int(int(sys.argv[1]))))
