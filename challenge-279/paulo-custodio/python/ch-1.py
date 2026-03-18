#!/usr/bin/env python3

# Perl Weekly Challenge 279 - Task 1 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-279/

import sys

if len(sys.argv) > 2:
    letters = sys.argv[1]
    weights = list(map(int, sys.argv[2:]))
    letters_list = list(letters)

    sorted_letters = sorted(zip(letters_list, weights), key=lambda x: x[1])
    result = ''.join(letter for letter, weight in sorted_letters)
    print(result)
else:
    raise SystemExit("Usage: {} LETTERS WEIGHTS...".format(sys.argv[0]))
