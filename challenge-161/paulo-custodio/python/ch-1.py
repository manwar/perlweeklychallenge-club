#!/usr/bin/env python3

# Challenge 161
#
# Task 1: Abecedarian Words
# Submitted by: Ryan J Thompson
# An abecedarian word is a word whose letters are arranged in alphabetical
# order. For example, "knotty" is an abecedarian word, but "knots" is not.
# Output or return a list of all abecedarian words in the dictionary, sorted
# in decreasing order of length.
#
# Optionally, using only abecedarian words, leave a short comment in your code
# to make your reviewer smile.

import sys

out = set()
with open(sys.argv[1]) as f:
    for line in f.readlines():
        word = line.rstrip()
        if len(word)>=3:
            abcd_word = "".join(sorted(word)).lower()
            if word==abcd_word:
                out.add(word)
for word in sorted(sorted(out), key=len, reverse=True):
    print(word)
