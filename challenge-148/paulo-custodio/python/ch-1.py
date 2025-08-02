#!/usr/bin/env python3

# Challenge 148
#
# TASK #1 > Eban Numbers
# Submitted by: Mohammad S Anwar
# Write a script to generate all Eban Numbers <= 100.
#
# An Eban number is a number that has no letter 'e' in it when the number
# is spelled in English (American or British).
#
# Example
# 2, 4, 6, 30, 32 are the first 5 Eban numbers.

from num2words import num2words

def is_eban(n):
    en = num2words(n)
    return 'e' not in en

out = []
for n in range(1, 101):
    if is_eban(n):
        out.append(n)

print(", ".join(map(str, out)))
