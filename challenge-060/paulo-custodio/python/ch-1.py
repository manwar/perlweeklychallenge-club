#!/usr/bin/env python3

# Challenge 060
#
# TASK #1 > Excel Column
# Reviewed by: Ryan Thompson
# Write a script that accepts a number and returns the Excel Column Name it
# represents and vice-versa.
#
# Excel columns start at A and increase lexicographically using the 26 letters
# of the English alphabet, A..Z. After Z, the columns pick up an extra "digit",
# going from AA, AB, etc., which could (in theory) continue to an arbitrary
# number of digits. In practice, Excel sheets are limited to 16,384 columns.
#
# Example
# Input Number: 28
# Output: AB
#
# Input Column Name: AD
# Output: 30

import re
import sys

def col2num(col):
    num = 0
    for digit in col:
        num = 26*num + ord(digit)-ord('A') + 1
    return num

def num2col(num):
    col = ""
    while num > 0:
        digit = (num-1) % 26
        num = int((num-1) / 26)
        col = chr(ord('A')+digit) + col
    return col

arg = sys.argv[1]
if re.search(r'^\d+$', arg):
    print(num2col(int(arg)))
else:
    print(col2num(arg))
