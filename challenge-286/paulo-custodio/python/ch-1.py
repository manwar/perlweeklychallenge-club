#!/usr/bin/env python3

# Challenge - word for the test.pl test case

# Perl Weekly Challenge 286 - Task 1 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-286/

# Challenge 286

import sys
from random import shuffle

n = -1
if len(sys.argv) == 2:
    n = int(sys.argv[1])

f = open(sys.argv[0], "r")
text = f.read()
words = text.split()

if n == -1:
    shuffle(words)
    print(words[0])
else:
    print(words[n])
