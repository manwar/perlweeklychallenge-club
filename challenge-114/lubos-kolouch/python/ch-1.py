#!/usr/bin/env python
# -*- coding: utf-8 -*-


def next_palindrome(n):
    while True:
        n += 1
        if str(n) == str(n)[::-1]:
            return n


# Test
print(next_palindrome(1234))  # Output: 1331
