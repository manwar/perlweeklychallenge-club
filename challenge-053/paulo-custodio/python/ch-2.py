#!/usr/bin/env python3

# Challenge 053
#
# TASK #2
# Vowel Strings
# Write a script to accept an integer 1 <= N <= 5 that would print all possible
# strings of size N formed by using only vowels (a, e, i, o, u).
#
# The string should follow the following rules:
#
# 'a' can only be followed by 'e' and 'i'.
#
# 'e' can only be followed by 'i'.
#
# 'i' can only be followed by 'a', 'e', 'o', and 'u'.
#
# 'o' can only be followed by 'a' and 'u'.
#
# 'u' can only be followed by 'o' and 'e'.
#
# For example, if the given integer N = 2 then script should print the following
# strings:
#
# ae
# ai
# ei
# ia
# io
# iu
# ie
# oa
# ou
# uo
# ue

import sys

def show_vowels(n, string):
    if len(string) == n:
        print(string)
    elif string == "":
        for vowel in ['a', 'e', 'i', 'o', 'u']:
            show_vowels(n, string+vowel)
    elif string[-1] == 'a':
        for vowel in ['e', 'i']:
            show_vowels(n, string+vowel)
    elif string[-1] == 'e':
        for vowel in ['i']:
            show_vowels(n, string+vowel)
    elif string[-1] == 'i':
        for vowel in ['a', 'e', 'o', 'u']:
            show_vowels(n, string+vowel)
    elif string[-1] == 'o':
        for vowel in ['a', 'u']:
            show_vowels(n, string+vowel)
    elif string[-1] == 'u':
        for vowel in ['e', 'o']:
            show_vowels(n, string+vowel)
    else:
        print("expected vowel, got "+string)

n = int(sys.argv[1])
show_vowels(n, "")
