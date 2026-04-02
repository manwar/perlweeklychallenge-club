#!/usr/bin/env python3

# Perl Weekly Challenge 176 - Task 1 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-176/

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
