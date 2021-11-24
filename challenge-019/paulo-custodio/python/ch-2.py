#!/usr/bin/python3

# Challenge 019
#
# Task #2
# Write a script that can wrap the given paragraph at a specified column using
# the greedy algorithm.

import fileinput
import sys

def read_input():
    lines = []
    for line in fileinput.input():
        lines.append(line)
    return lines

def wrap(text, column):
    output = ""
    pos = 0
    sep = ""
    for word in (text.split()):
        if pos+len(sep)+len(word) >= column:
            output += "\n"
            sep = ""
            pos = 0
        output += sep+word
        pos += len(sep)+len(word)
        sep = " "
    return output

print(wrap(" ".join(read_input()), 72))
