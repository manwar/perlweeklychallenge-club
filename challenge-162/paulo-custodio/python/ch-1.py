#!/usr/bin/env python3

# Challenge 162
#
# Task 1: ISBN-13
# Submitted by: Mohammad S Anwar
# Write a script to generate the check digit of given ISBN-13 code. Please
# refer wikipedia for more information.
#
# Example
# ISBN-13 check digit for '978-0-306-40615-7' is 7.

import sys

def isbn13_check_digit(isbn):
    m = 1
    sum_ = 0
    isbn = isbn.replace('-', '')
    for i in range(12):
        digit = int(isbn[i])
        sum_ += m * digit
        m = 3 if m==1 else 1
    digit = sum_ % 10
    if digit != 0:
        digit = 10-digit
    return digit

print(isbn13_check_digit(sys.argv[1]))
