#!/usr/bin/env python3

# Challenge 160
#
# TASK #1 > Four Is Magic
# Submitted by: Mohammad S Anwar
# You are given a positive number, $n < 10.
#
# Write a script to generate english text sequence starting with the English
# cardinal representation of the given number, the word 'is' and then the
# English cardinal representation of the count of characters that made up the
# first word, followed by a comma. Continue until you reach four.
#
#
# Example 1:
# Input: $n = 5
# Output: Five is four, four is magic.
#
# Example 2:
# Input: $n = 7
# Output: Seven is five, five is four, four is magic.
#
# Example 3:
# Input: $n = 6
# Output: Six is three, three is five, five is four, four is magic.

import sys
from num2words import num2words

def sequence(n=1):
    out = []
    while n != 4:
        num_en = num2words(n)
        length = len(num_en)
        len_en = num2words(length)

        out.append(f"{num_en} is {len_en}")
        n = length

    out.append("four is magic.")
    out[0] = out[0].capitalize()
    return ", ".join(out)

print(sequence(int(sys.argv[1])))
