#!/usr/bin/env python
# -*- coding: utf-8 -*-

def is_binary_palindrome(N):
    binary_rep = bin(N)[2:]
    return int(binary_rep == binary_rep[::-1])


# Tests
print(is_binary_palindrome(5))  # Output: 1
print(is_binary_palindrome(4))  # Output: 0
