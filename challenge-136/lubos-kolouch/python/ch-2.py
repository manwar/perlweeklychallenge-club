#!/usr/bin/env python
# -*- coding: utf-8 -*-

def count_fib_sequences(n, i, fib):
    if n < 0:
        return 0
    if n == 0:
        return 1
    if i == len(fib):
        return 0
    return count_fib_sequences(n - fib[i], i+1, fib) + count_fib_sequences(n, i+1, fib)


fib = [1, 2, 3, 5, 8, 13, 21, 34, 55, 89]
print(count_fib_sequences(16, 0, fib))
print(count_fib_sequences(9, 0, fib))
print(count_fib_sequences(15, 0, fib))
