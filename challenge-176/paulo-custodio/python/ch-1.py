#!/usr/bin/env python3

# Challenge 176
#
# Task 1: Permuted Multiples
# Submitted by: Mohammad S Anwar
#
# Write a script to find the smallest positive integer x such that x, 2x, 3x,
# 4x, 5x and 6x are permuted multiples of each other.
#
# For example, the integers 125874 and 251748 are permutated multiples of each
# other as
#
# 251784 = 2 x 125874
#
# and also both have the same digits but in different order.
#
# Output
#
# 142857

def is_permuted(a, b):
    return sorted(a) == sorted(b)

def is_permuted_multiple(n, k):
    return is_permuted(str(n), str(n * k))

def is_permuted_multiples(n):
    return (is_permuted_multiple(n, 2) and
            is_permuted_multiple(n, 3) and
            is_permuted_multiple(n, 4) and
            is_permuted_multiple(n, 5) and
            is_permuted_multiple(n, 6))

def smallest_permuted_multiples():
    n = 1
    while True:
        if is_permuted_multiples(n):
            return n
        n += 1

print(smallest_permuted_multiples())
