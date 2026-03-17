#!/usr/bin/env python3

# Perl Weekly Challenge 290 - Task 2 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-290/

import sys

def is_luhn(s):
    s = ''.join(filter(str.isdigit, s))
    payload = int(s[-1])
    sum_ = 0
    factor = 2
    for i in range(len(s) - 2, -1, -1):
        digit = factor * int(s[i])
        if digit > 9:
            sum_ += sum(int(d) for d in str(digit))
        else:
            sum_ += digit
        factor = 3 - factor
    return (sum_ + payload) % 10 == 0

print("true" if is_luhn(" ".join(sys.argv[1:])) else "false")
