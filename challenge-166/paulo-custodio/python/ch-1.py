#!/usr/bin/env python3

# Perl Weekly Challenge 166 - Task 1 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-166/

import sys

if len(sys.argv) != 2:
    sys.exit("usage: ch-1.py words.txt")

f = open(sys.argv[1], "r")
for line in f.readlines():
    word = line.strip()
    if len(word) >= 2 and len(word) <= 8 and all(c in 'abcdefolist' for c in word.lower()):
        word = word.translate(str.maketrans('olist', '01157'))
        print("0x" + word.upper())
