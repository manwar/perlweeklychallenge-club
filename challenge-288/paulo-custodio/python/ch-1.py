#!/usr/bin/env python3

# Perl Weekly Challenge 288 - Task 1 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-288/

import sys

def is_palindrome(n):
    return str(n) == str(n)[::-1]

def next_palindrome(n):
    out = None
    i = 1
    while out is None or i <= n:
        t = n-i
        if t >= 0 and is_palindrome(t):
            if out is None:
                out = t
            elif abs(out-n) > abs(t-n):
                out = t
        t = n+i
        if is_palindrome(t):
            if out is None:
                out = t
            elif abs(out-n) > abs(t-n):
                out = t
        i += 1
    return out

n = int(sys.argv[1])
print(next_palindrome(n))
