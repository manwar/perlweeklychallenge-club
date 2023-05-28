#!/usr/bin/env python
# -*- coding: utf-8 -*-


def next_same_bits(n):
    binary = bin(n)[2:]
    one_bits = binary.count("1")
    while True:
        n += 1
        if bin(n)[2:].count("1") == one_bits:
            return n


# Test
print(next_same_bits(3))  # Output: 5
