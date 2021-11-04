#!/usr/bin/env python3

# Challenge 111
#
# TASK #2 - Ordered Letters
# Submitted by: E. Choroba
# Given a word, you can sort its letters alphabetically (case insensitive).
# For example, "beekeeper" becomes "beeeeekpr" and "dictionary" becomes
# "acdiinorty".
#
# Write a script to find the longest English words that don't change when
# their letters are sorted.

import fileinput
import sys

def read_input():
    lines = []
    for line in fileinput.input():
        lines.append(line)
    return lines

def find_longest(lines):
    max_len = 0
    words = []
    for word in lines:
        word = word.strip().lower()
        drow = "".join(sorted(word))
        if word==drow:
            max_len = max(max_len, len(word))
            words.append(word)
    words = list(filter(lambda x: len(x)==max_len, words))
    return words

print(" ".join(find_longest(read_input())))
