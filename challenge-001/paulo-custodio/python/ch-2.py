#!/usr/bin/env python

# Perl Weekly Challenge 001 - Task 2 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-001/

import sys

for i in range(1, int(sys.argv[1])+1):
    if i%15==0:
        print("fizzbuzz")
    elif i%3==0:
        print("fizz")
    elif i%5==0:
        print("buzz")
    else:
        print(i)
