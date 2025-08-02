#!/usr/bin/env perl

# Challenge 150
#
# TASK #1 > Fibonacci Words
# Submitted by: Mohammad S Anwar
#
# You are given two strings having same number of digits, $a and $b.
#
# Write a script to generate Fibonacci Words by concatenation of the previous
# two strings. Finally print 51st digit of the first term having at least
# 51 digits.
# Example:
#
#     Input: $a = '1234' $b = '5678'
#     Output: 7
#
#     Fibonacci Words:
#
#     '1234'
#     '5678'
#     '12345678'
#     '567812345678'
#     '12345678567812345678'
#     '56781234567812345678567812345678'
#     '1234567856781234567856781234567812345678567812345678'
#
#     The 51st digit in the first term having at least 51 digits
#     '1234567856781234567856781234567812345678567812345678' is 7.

import sys

pos = 51

def fib_word(a, b, length):
    seq = [a, b]
    while len(seq[-1]) <= length:
        seq.append(seq[-2] + seq[-1])
        seq.pop(0)
    return seq[-1]

words = sys.argv[1:3]
fib_word_result = fib_word(words[0], words[1], pos)
print(fib_word_result[pos - 1])
